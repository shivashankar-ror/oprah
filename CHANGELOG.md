0.1.3
-----

- Presenters can now be specified using the `only:` keyword
  argument, which takes either a Class or an Array of classes
- Replace repeated method default arguments with splats
- Add assertions to TestHelper
- Delegate to most recent view context in presenters created
  from within Rails controllers [#1]

0.1.2
-----

- Explicitly rescue NameError in Cache#presenter_classes_for
- Add Oprah::TestHelpers
- Delegate #to_s and #inspect to the presented object

0.1.1
-----

- Initial public release
