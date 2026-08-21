-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/store/facade/RechargeFacade.lua

module("logic.extensions.store.facade.RechargeFacade", package.seeall)

local RechargeFacade = class("RechargeFacade")

function RechargeFacade:ctor()
	return
end

function RechargeFacade:pay(paymentInfo, roleInfo)
	SDKManager.getSDKInstacne():pay(paymentInfo, roleInfo)
end

RechargeFacade.instance = RechargeFacade.New()

return RechargeFacade
