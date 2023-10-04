# Visor de personajes de Rick y Morty

## Descripción general

Rick and Morty es una aplicación que permite explorar y ver detalles de los personajes del programa de televisión animado "Rick and Morty".

## Características

- Listado de personajes de "Rick y Morty" con sus nombres y especies.
- Vista detallada del personaje que muestra información adicional, incluido el estado, el sexo, la fecha de creación y los episodios.
- Integración con la API de Rick and Morty para recuperar datos de personajes.
- Navegación entre la lista de personajes y la vista detallada.

### Requisitos previos

- Una conexión a Internet estable (para obtener datos de personajes de la API)

### Uso

- Inicie la aplicación para ver una lista de personajes de "Rick and Morty".
- Toca un personaje para ver sus detalles, incluido el estado, el género y los episodios.

## Arquitectura MVVM

Este proyecto sigue la arquitectura MVVM (Model-View-ViewModel):

- **Modelo:** La estructura `Character` representa la estructura de datos de personajes.
- **Vistas:** Las vistas (`ContentView` y `CharacterDetailView`) muestran la interfaz de usuario y observan el ViewModel en busca de datos.
- **ViewModel:** `CharacterViewModel` recupera y procesa datos de personajes de la API de Rick and Morty. También gestiona el estado de carga.

## Dependencias

- [API de Rick and Morty] (https://rickandmortyapi.com/): la API se utiliza para recuperar datos de personajes.

## Agradecimientos

- Los datos de esta aplicación provienen de la [API de Rick and Morty] (https://rickandmortyapi.com/).

