## Review of TICKET-101 FRONTEND

### Good Parts

- Intern created a working MVP version of the task
- Intern followed `Seperation of Concern` concept and split the `color`,`fonts` and `slider_style` into separate files. This increased the readability and reusability of the code.
- Color choices and design looks nice and it has user friendly UI.
- Async web requests separated from UI view components and that made it easier to read and understand the code

### Problems & Improvement Suggestions
- There are suggestions from `Dart linter` that could be fixed before the PR.
- the key could be provided by using [super initializer](https://dart.dev/tools/linter-rules/use_super_parameters) concept
- We can use `const` for the constant elements such as `Row`, `Column` as suggested [here](https://dart.dev/tools/linter-rules/prefer_const_constructors)
- I believe the intern tried to add the backend as submodule in github project but there is a folder called `inbank-frontend-98f09aabec29a741365f750db29dfe606f20f0b2` which sounds like a git submodule but its actually the same frontend project
- I could not understand the defined title `Act. Apply for a loan.` and I would appreciate the meaning of `Act`.
- UI sends a request to backend for each change that happens on sliders. This approach is dangerous as it makes user to send a lot of requests and it makes the user act like an attacker who tries to do Denial of Service (DoS) attack. 
- The slider for amount and period doing an unusual conversion from double to int. I suggest that we should use built-in functions like `toInt()` instead of rounding and dividing and multiplying with same constant.
- Slider divisions for loan period are not matching with the remainder. Max value is 60 and min value is 12 and that means there are 48 number between them and selecting the division 40 means that there will be 40 different interval for slider to calculate and this will make the increment value 1.2 (48/40) and I believe this can cause unpredictible bugs as we are using that value to set our loan period.
- Main function has `MaterialApp` wrapped the `InBank Form` but `InBank Form` itself is already wrapped by `MaterialApp` by default. There is no need for 2 `MaterialApp` nesting.
- Using `Expanded` when it is not descendant of `Row`, `Column`, `Flex` widget. It creates exception issues that is visible in logs or console of the browser `Another exception was thrown: Incorrect use of ParentDataWidget.`
- Overflow happens on bottom of the UI when height is between (750,800] pixel height. The headline does not disappear and it makes the bottom UI to overflow as it takes 81 pixel (54 font size * 1.5 line height). Increasing the minHeight  to `540` would fix the problem but still, We could change the view structure and add scrollable view to eliminate overflow cases but that means user might need to scroll when its needed.
- in `Samsung Galaxy A51/71` view of chrome, the headline uses 2 rows as the width is not fitting the text and this causes overflow as well. The temporary solution would be reducing the font size.