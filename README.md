# test_task_hh

Из-за ограниченного времени, для инпутов использовал контроллеры,  из-за чего появились StatefulWidget-ы в двух местах. Обычно я использую связку Form + FormFields.
Также из-за ограниченного времени в качестве навигации использовал встроенный Navigator, обычно использую AutoRoute. 
Также некоторую часть логики можно было бы сократить работая с backend. Например, при возврате на список задач, я бы вызывал метод GET для получения обновленного списка и много кода бы ушло.

