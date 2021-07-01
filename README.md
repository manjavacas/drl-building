**Trabajo Fin de Máster. Máster Oficial en Ciencia de Datos e Ingeniería de Computadores**

Autor: Antonio Manjavacas Lucas (<manjavacas@correo.ugr.es>)

Curso: 2020-2021

Universidad de Granada

# Deep Reinforcement Learning para control energético eficiente de edificios

## Resumen

En las últimas décadas, tanto el calentamiento global como el cambio climático se han visto significativamente alentados por la demanda energética de edificios residenciales y comerciales. Estos son responsables de un tercio del consumo mundial de energía y de hasta un 40\% de las emisiones de $$CO_2$$, mayormente producidas por los sistemas de calefacción, ventilación y aire acondicionado (HVAC) destinados a garantizar el bienestar de sus ocupantes.

Ante esta problemática, optimizar el control de los sistemas HVAC se plantea como una solución necesaria ante el creciente interés por garantizar la eficiencia energética de los edificios. Dicho control ha sido tradicionalmente llevado a cabo mediante técnicas basadas en modelos de predicción, los cuales no siempre garantizan la maximización del confort de los ocupantes y, al mismo tiempo, la minimización del consumo energético.

En contraposición a estos métodos tradicionales, en los últimos años se ha experimentado una notable tendencia al uso de técnicas basadas en aprendizaje profundo por refuerzo (DRL) orientadas a control HVAC, logrando mejorar los resultados ofrecidos por métodos de control convencionales. No obstante, se trata de un campo relativamente inmaduro, donde se carece de marcos de referencia y bancos de prueba específicamente destinados a reproducir y comparar los diferentes algoritmos que conforman el estado del arte.

En respuesta a esta necesidad, el objetivo perseguido en este trabajo será el desarrollo de un entorno de ejecución de simulaciones energéticas orientado al uso y evaluación de diferentes algoritmos de DRL en control HVAC. A su vez, se profundizará en la experimentación con estos algoritmos haciendo uso del entorno implementado, evaluando los resultados obtenidos en términos de consumo energético y confort.

## Guía del repositorio

* [agents](https://github.com/manjavacas/drl-building/tree/main/agents): _scripts_ destinados al entrenamiento y ejecución de los agentes empleados. Estos son:
    - [A2C](https://stable-baselines3.readthedocs.io/en/master/modules/a2c.html): _Advantage Actor Critic_.
    - [PPO](https://stable-baselines3.readthedocs.io/en/master/modules/ppo.html): _Proximal Policy Optimization_.
    - [DQN](https://stable-baselines3.readthedocs.io/en/master/modules/dqn.html): _Deep Q-Networks_.
    - [DDPG](https://stable-baselines3.readthedocs.io/en/master/modules/ddpg.html): _Deep Deterministic Policy Gradient_.
    - [SAC](https://stable-baselines3.readthedocs.io/en/master/modules/ppo.html): _Soft Actor Critic_.
    - RBC: controlador basado en reglas.
    - RAND: agente aleatorio.
* [mlruns](https://github.com/manjavacas/drl-building/tree/main/mlruns/0): historial de ejecuciones registrado por [MLflow](https://mlflow.org/).
* [models](https://github.com/manjavacas/drl-building/tree/main/models): modelos entrenados.
* [plots](https://github.com/manjavacas/drl-building/tree/main/plots): datos y gráficos generados a partir de los resultados de las simulaciones.
* [tensorboard_logs](https://github.com/manjavacas/drl-building/tree/main/tensorboard_log): _logs_ registrados durante los entrenamiento y empleados por [TensorBoard](https://www.tensorflow.org/tensorboard).

## Información adicional

Los resultados han sido obtenidos a partir del entrenamiento y ejecución de diferentes agentes en el entorno de ejecución de simulaciones energéticas [Energym](https://github.com/jajimer/energym) (versión 1.0.0), elaborado a lo largo de este TFM. Pulsa [aquí](https://energym.readthedocs.io/) para acceder a la documentación de Energym.
