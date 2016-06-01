#pragma once
#include <Ice/Identity.ice>
#include <Ice/Instrumentation.ice>

module Vistek
{
	module Device
	{
		class CpuInfo
		{
			float cpuUseRate;//0-100
			optional(0) int cpuCount = 0;
			optional(1) int physicCpuCount = 0;
		}
		class MemInfo
		{
			float memSize;
			float useMem;
			float aviableMemSize;
			float memUseRate;//0-100
		}
		class RegisterInfo
		{
			int registerSuccessCount;
			int registerFailCount;
			sequence<string> registerSucccessDeviceList;//DeviceID
			sequence<string> registerFailDeviceList;//DeviceID
		}
		class BasePhyServiceInfo
		{
			string serviceID;
			CpuInfo cpuInfo;
			MemInfo memInfo;
			RegisterInfo registerInfo;
		}
		sequence<BasePhyServiceInfo> BasePhyServiceInfoList;
		
		enum ServiceStatusType{ vStatusOK=0, vStatusError=-1}
		class ServiceStaus
		{
			ServiceStatusType status;
			optional(0) string error_msg;
		}
				
		interface BaseWatchService
		{
			idempotent string GetServiceRunningInfo();//device running info with xml string.
			idempotent ServiceStatus isDeviceServiceOk();
		}
		
		interface DeviceWatchService extends BaseWatchService
		{
			idempotent BasePhyServiceInfo GetPhysicInfo();
		}
		
	};
};