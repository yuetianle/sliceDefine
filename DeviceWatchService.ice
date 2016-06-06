#pragma once
#include <Ice/Identity.ice>
#include <Ice/Instrumentation.ice>

module Vistek
{
	module Device
	{
		["clr:property"]
		class CpuInfo
		{
			float cpuUseRate;//0-100
			optional(0) int cpuCount = 0;
			optional(1) int physicCpuCount = 0;
		};
		["clr:property"]
		class MemInfo
		{
			float memSize;
			float useMem;
			float aviableMemSize;
			float memUseRate;//0-100
		};
		["clr:property"]
		class RegisterInfo
		{
			int registerSuccessCount;
			int registerFailCount;
			string registerSucccessDeviceList;//DeviceID
			string registerFailDeviceList;//DeviceID
		};
		["clr:property"]
		class BasePhyServiceInfo
		{
			string serviceID;
			CpuInfo cpuInfo;
			MemInfo memInfo;
			RegisterInfo registerInfo;
		};
		["clr:property"]
		sequence<BasePhyServiceInfo> BasePhyServiceInfoList;
		
		enum ServiceStatusType{ vStatusOK=0, vStatusError=1};
		["clr:property"]
		class ServiceStatus
		{
			ServiceStatusType status;
			optional(0) string error_msg;
		};
				
		interface BaseWatchService
		{
			idempotent string GetServiceRunningInfo();//device running info with xml string.
			idempotent ServiceStatus isDeviceServiceOk();
		};

		interface DeviceWatchService extends BaseWatchService
		{
			idempotent BasePhyServiceInfoList GetPhysicInfo();
		};
		
	};
};