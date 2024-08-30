## Overview
React is a declarative, efficient, and flexible JavaScript library for building user interfaces. It lets you compose complex UIs from small and isolated pieces of code called "components."

## Features
- **Declarative**: React makes it easy to create interactive UIs by efficiently updating and rendering just the right components when your data changes.
- **Learn Once, Write Anywhere**: React can render on the server using Node and power mobile apps using React Native.

## Code Overview
### JSX
React components are typically written in JSX format, which are is to to HTML , more like an extension.

### Components
Components are the building blocks of a React application. They can be defined as:
- **Functional Components**: Functions that return JSX.
    ```javascript
    function Welcome(props) {
        return <h1>Hello, {props.name}</h1>;
    }
    ```
- **Class Components**: ES6 classes that extend `React.Component` and include a `render` method.
    ```javascript
    class Welcome extends React.Component {
        render() {
            return <h1>Hello, {this.props.name}</h1>;
        }
    }
    ```

### State and Props
- **State**: State is a built-in object used to contain data or information about the component. It is managed within the component and can change over time.
- **Props**: Props are inputs to a React component. They are passed to the component via attributes in JSX and are immutable within the component.

### Lifecycle Methods
React components have several lifecycle methods that you can override to run code at particular times in the process:
- `componentDidMount()`
- `shouldComponentUpdate()`
- `componentDidUpdate()`
- `componentWillUnmount()`

### Hooks
Hooks are a newer addition to React that let you use state and other React features without writing a class. Examples include:
- `useState()`
- `useEffect()`
- `useContext()`

