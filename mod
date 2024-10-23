/**
* @name F1 Racing Keybind
* @description Keybind for F1 Racing
* @author Getrithekd
*/


const BRAKE_KEY = "q";
const ACCEL_KEY = "e";

let brake = false;
let accel = false;

const DEVICE_KEY = "AHXLRHGFPqfpKF_gZA1d8";


let brakeInterval,accelInterval;

let brakeLastTick = false;
let brakeIntervalSet = false;

let accelLastTick = false;
let accelIntervalSet = false;

addEventListener("keydown",(event)=>{
  if (event.key == BRAKE_KEY){
    brake = true;
  } 
  if (event.key == ACCEL_KEY){
    accel = true;
  }
});

addEventListener("keyup",(event)=>{
  if (event.key == BRAKE_KEY){
    brake = false;
  }
  if (event.key == ACCEL_KEY){
    accel = false;
  }
});

function broadcastBrake() {
  window.stores.network.room.send("MESSAGE_FOR_DEVICE",{"key":"primaryCallToAction","deviceId":DEVICE_KEY});
  console.log("BRAKE");
}
function broadcastAccel(){
  window.stores.network.room.send("MESSAGE_FOR_DEVICE",{"key":"secondaryCallToAction","deviceId":DEVICE_KEY});
  console.log("ACCEL");
}


const interval  = setInterval(() => {
   if (brake){
     if (brakeLastTick&&!brakeIntervalSet){
       brakeInterval = setInterval(()=>{
         broadcastBrake();
       },100);

       brakeIntervalSet = true;
     } else if (!brakeLastTick){
       broadcastBrake();
       brakeLastTick = true;
     }
   } else if (accel){
     if (accelLastTick&&!accelIntervalSet){
       accelInterval = setInterval(()=>{
         broadcastAccel();
       },200);

       accelIntervalSet = true;
     } else if (!accelLastTick){
       broadcastAccel();
       accelLastTick = true;
     }
   }

  if (!brake){
    clearInterval(brakeInterval);
    brakeIntervalSet = false;
  } 
  if (!accel){
    clearInterval(accelInterval);
    accelIntervalSet = false;
  }
},10);

console.log("Loop set")

export function stop(){
  clearInterval(brakeInterval);
  clearInterval(accelInterval);
  clearInterval(interval);
}

