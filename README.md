# IoT Starter for iOS
IoT Starter is a demo application for interacting with the IBM Watson Internet of Things (IoT) Platform.
The application turns your mobile device into a sensor that publishes and receives data to and from the cloud using the MQTT protocol.

For the Android version, refer to [IoT Starter for Android](https://github.com/ibm-messaging/iot-starter-for-android)

## Short description
The Watson IoT Platform is a cloud-hosted service to simplify managing all of your IoT devices. The key features provided by the service include:
- Device management
- Scalable connectivity
- Secure communication
- Historical data

This application demonstrates using an iOS device as an IoT device, and provides a variety of events
and commands that it can publish or receive data to and from.

Events and commands are user defined values used to differentiate the data that you publish or receive. For example, if you have a device that is publishing GPS coordinates, you may choose to publish it as a 'GPS' event. Or, if you want to send an alert command to a device, you may choose to publish it as an 'alert' or 'notification' command.

The application can publish data to the following IoT event topics:
- Accelerometer (accel event)
- Touchmove (touchmove event)
- Text (text event)

The application can receive data on the following IoT command topics:
- Color (color command)
- Light (light command)
- Text (text command)
- Alert (alert command)

For more information on the Watson IoT Platform, refer to https://docs.internetofthings.ibmcloud.com/index.html

## How it works
A device that is registered with the Watson IoT Platform may publish and subscribe to data that is presented as either an event or command using the MQTT protocol.
The IBM WebSphere iOS MQTT Client is used to publish and subscribe to the Watson IoT Platform. This client can be downloaded as part of the [Mobile Messaging & M2M Client Pack](https://www.ibm.com/developerworks/community/blogs/c565c720-fe84-4f63-873f-607d87787327/entry/download?lang=en).

MQTT is a lightweight messaging protocol that supports publish/subscribe messaging. With MQTT, an application publishes messages to a topic. These messages may then be received by another application that is subscribed to that topic. This allows for a detached messaging network where the subscribers and publishers do not need to be aware of each other.
The topics used by this application can be seen in the table below:

## Topics
|Topic|Sample Topic|Sample Message|
|:---------- |:---------- |:------------|
|`iot-2/evt/<eventId>/fmt/json`|`iot-2/evt/touchmove/fmt/json`|`{"d":{"screenX":0,"screenY":0,"deltaX":0,"deltaY":0}}`|
|`iot-2/cmd/<commandId>/fmt/json`|`iot-2/cmd/light/fmt/json`|`{"d":{"light":"toggle"}}`|

For more information on the MQTT protocol, see http://mqtt.org/

## Try it
The IoT Starter application can be used in 2 ways.

### 1. Connect to IoT Quickstart
In order to connect to IoT Quickstart, all you need to do is specify 'quickstart' as the organization and enter a valid device id. The Auth Token field can be left blank. The device-id is a 12 hexadecimal character MAC address in lower case, without delimiting characters. For example, a36d7c91bf9e. For more details, refer to the [MQTT Connectivity for Devices](https://docs.internetofthings.ibmcloud.com/devices/mqtt.html).

Once the app is connected, you can see the data visualized by going to [IoT Quickstart](https://quickstart.internetofthings.ibmcloud.com/) and entering the same device-id in the MAC address field.

### 2. Connect to an IoT organization as a registered device
In order to try the application as a registered device, you must have a Watson IoT Platform organization. This can be done by signing up for an IBM Bluemix trial and creating an instance of the Internet of Things Platform service. This will create an IoT organization where you can register devices. Next, you must register your device with your organization. When registering your device, create a new device type called `iPhone` (case sensitive). More detailed instructions on registering devices can be found at the [IBM Watson Internet of Things Platform documentation](https://docs.internetofthings.ibmcloud.com/index.html).

On launching the application for the first time, you will need to enter your credentials to connect your device to the Watson IoT Platform. The required information to connect your device includes:

- Your Organization ID, e.g. ab1cde
- Your Device ID, e.g. the MAC Address of your device. This should be the same ID as the device that you registered in your Watson IoT Platform organization.
- Your device authorization token. This is returned when registering your device with the Watson IoT Platform.

Once you have entered the necessary credentials, you may activate your device as a sensor. Pressing the 'Activate Sensor' button will connect the device to the Watson IoT Platform and allow it to begin publishing and receiving data.

## Prerequisites
Required:
- An [IBM Bluemix](https://console.ng.bluemix.net/) account. A 30 day trial account is free.
- An Internet of Things Platform service registered in Bluemix.
- Apple XCode.

## Notes
In order to really see this demo do something, you must have an application to consume its data and publish data back
to the IoT Starter application. For examples, refer to the [IoT Starter demo](http://m2m.demos.ibm.com/iotstarter.html).

## Resources
- [IoT Starter](http://m2m.demos.ibm.com/iotstarter.html)
- [IoT Starter for Android](https://github.com/ibm-messaging/iot-starter-for-android)
- [IBM Watson Internet of Things Platform](https://internetofthings.ibmcloud.com/#/)
- [IBM Bluemix](https://console.ng.bluemix.net/)
- [IoT Recipes](https://developer.ibm.com/iot/)
- [IoT Quickstart](http://quickstart.internetofthings.ibmcloud.com/#/)
- [Node-RED](http://nodered.org/)
- [MQTT](http://mqtt.org/)
# superapp_for_ios
# superapp_for_ios
