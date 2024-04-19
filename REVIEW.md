## Review of TICKET-101 FRONTEND

### Good Parts

- Intern created a working MVP version of the task
- Intern followed `Seperation of Concern` concept and split the `color`,`fonts` and `slider_style` into separate files. This increased the readability and reusability of the code.
- Color choices and design looks nice and it has user friendly UI.
- Async web requests separated from UI view components and that made it easier to read and understand the code
- It has tests for `api_service` and `loan_form`
- it limits the user input in `personal code` field by asking 11 character and not letting the user type characters and it does validation


### Problems & Improvement Suggestions
- There are suggestions from `Dart linter` that could be fixed before the PR.
- the key could be provided by using [super initializer](https://dart.dev/tools/linter-rules/use_super_parameters) concept
- We can use `const` for the constant elements such as `Row`, `Column` as suggested [here](https://dart.dev/tools/linter-rules/prefer_const_constructors)
- I believe the intern tried to add the backend as submodule in github project but there is a folder called `inbank-frontend-98f09aabec29a741365f750db29dfe606f20f0b2` which sounds like a git submodule but its actually the same frontend project
- I could not understand the defined title `Act. Apply for a loan.` and I would appreciate the meaning of `Act`.
- UI sends a request to backend for each change that happens on sliders. This approach is dangerous as it makes user to send a lot of requests and it makes the user act like an attacker who tries to do Denial of Service (DoS) attack.
- The loan period changes by 6 months in the slider. I am not sure it is by design or by mistake. In my opinion the month slider should change by 1 month rather than 6 months as the task does not specify it to be changing by 6 months. Also in the backend we are increasing the period by `loanPeriod++` rather than ` loanPeriod += 6` so this means that the result from backend is not going to be multiples of 6 in terms of loan period. I believe user needs to have freedom to choose and I am not seeing any requirement that would make us put this kind of limitation.
- The slider for amount and period doing an unusual conversion from double to int. I suggest that we should use built-in functions like `toInt()` instead of rounding and dividing and multiplying with same constant.
- Slider divisions for loan period are not matching with the remainder. Max value is 60 and min value is 12 and that means there are 48 number between them and selecting the division 40 means that there will be 40 different interval for slider to calculate and this will make the increment value 1.2 (48/40) and I believe this can cause unpredictible bugs as we are using that value to set our loan period.
- Main function has `MaterialApp` wrapped the `InBank Form` but `InBank Form` itself is already wrapped by `MaterialApp` by default. There is no need for 2 `MaterialApp` nesting.
- Using `Expanded` when it is not descendant of `Row`, `Column`, `Flex` widget. It creates exception issues that is visible in logs or console of the browser `Another exception was thrown: Incorrect use of ParentDataWidget.`
- Overflow happens on bottom of the UI when height is between (750,800] pixel height. The headline does not disappear and it makes the bottom UI to overflow as it takes 81 pixel (54 font size * 1.5 line height). Increasing the minHeight  to `540` would fix the problem but still, We could change the view structure and add scrollable view to eliminate overflow cases but that means user might need to scroll when its needed.
- in `Samsung Galaxy A51/71` view of chrome, the headline uses 2 rows as the width is not fitting the text and this causes overflow as well. The temporary solution would be reducing the font size.
- in UI, Loan period slider displays `6 months` as minimum value but it is actually `12 month` but this is only visual problem, the minimum value that slider can be set is still 12. We just need to change the text.
- In `api_service` test `requestLoanDecision returns a valid decision` uses invalid response as expected response. This is technically not a problem but it might create confusion into making the frontend developer to think that if they provide same query, backend should respond as valid loan but it is not the case as the user is segment 1 user and it tries to request 10000$ with 12 month period.
- In `api_service` test `requestLoanDecision returns an error message` uses invalid loan amount (50.000$) and expect that the error would be `Loan application denied` but it should be expecting `Invalid loan amount!`
- In `loan_form` test `LoanForm slider changes the loan amount` asserts that slider points to `2500` after it is slided but this approach is problematic. As the default value is `2500` the test gives an illusion of testing. Test is trying to use the same widget but the sliding action is not updating the widget that is created by `tester.widget` method. After the movement, test needs to create the updated version of the widget by using the same finder, in order to see the new value of it.
- The same behavior is true for `LoanForm slider changes the loan period` test case as well. It tests the default case and needs the same modification that I mentioned in my previous point.
- In `api_service` we can use conditional operator and eliminate some verbose parts of the code.
- `_submitForm` method inside of `loan_form` can use guard cause to simplify and improve the readability of the codebase. This method also tries to update state variables without calling setState in case validation fails. I also believe that there is unnecessary if conditions which does not bring any value other than increasing the code complexity. These if cases also causes frontend to display the user defined loan amount and period and that causes a UI bug when we approve more loan than the asked, user still sees the amount that s/he provided.


## Subjective topics

- I believe we can group similar files/widget into folders to make the workflow easier to understand. For example, we can move the `api_service` to `service` folder and we can move `fonts`,`colors`, `slider_style` to `utils` folder. I believe this would provide better codebase structure.
- There are lots of files and folders that are related to multi-platform builds. As I am not expert on Flutter side, I would like to clarify if we really need these files on our github repository? Because if these files can be re-generated on user side without having a side-effect, then there is no reason to pollute our repository with unused files that are related to internal system of flutter.
- We can add some linter and formatter to bring an order to the code style. (Eslint, Prettier etc.)
