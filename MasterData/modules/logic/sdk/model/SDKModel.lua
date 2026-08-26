-- chunkname: @modules/logic/sdk/model/SDKModel.lua

module("modules.logic.sdk.model.SDKModel", package.seeall)

local SDKModel = class("SDKModel", BaseModel)

function SDKModel:onInit()
	self:reInit()

	local channelId = SDKMgr.instance:getChannelId()
	local subChannelId = SDKMgr.instance:getSubChannelId()

	self._isDmm = channelId == "301"
	self._isSteam_GL = subChannelId == "6007"
	self._isSteam_JP = subChannelId == "6008"
end

function SDKModel:reInit()
	self._baseProperties = {}

	self:_modifyTrackDefine()
end

function SDKModel:isDmm()
	return self._isDmm
end

function SDKModel:setNeedShowATTWithGetIDFA(v)
	local key = string.format(PlayerPrefsKey.NeedShowATTWithGetIDFA, PlayerModel.instance:getMyUserId())

	PlayerPrefsHelper.setNumber(key, v ~= false and 1 or 0)
end

function SDKModel:getNeedShowATTWithGetIDFA()
	local key = string.format(PlayerPrefsKey.NeedShowATTWithGetIDFA, PlayerModel.instance:getMyUserId())

	return PlayerPrefsHelper.getNumber(key, 1) == 1
end

function SDKModel:_updateBaseProperties()
	local basePropertiesStr = SDKDataTrackMgr.instance:getDataTrackProperties()

	if string.nilorempty(basePropertiesStr) then
		basePropertiesStr = cjson.encode(StatEnum.DefaultBaseProperties)
	end

	self._baseProperties = cjson.decode(basePropertiesStr)

	StatRpc.instance:sendUpdateClientStatBaseInfoRequest(basePropertiesStr)
end

function SDKModel:updateBaseProperties(code, msg)
	self:_updateBaseProperties()
	SDKController.instance:dispatchEvent(SDKEvent.BasePropertiesChange, code, msg)
end

function SDKModel:isVistor()
	return SDKMgr.instance:getUserType() == SDKEnum.AccountType.Guest
end

function SDKModel:setAccountBindBonus(accountBindBonus)
	local last = self.accountBindBonus

	self.accountBindBonus = accountBindBonus

	if last and last ~= accountBindBonus then
		SDKController.instance:dispatchEvent(SDKEvent.UpdateAccountBindBonus, last, accountBindBonus)
	end
end

function SDKModel:getAccountBindBonus()
	return self.accountBindBonus or SDKEnum.RewardType.None
end

function SDKModel:_modifyTrackDefine()
	self:_modifyTrackDefine_EventName()
	self:_modifyTrackDefine_EventProperties()
	self:_modifyTrackDefine_PropertyTypes()
end

function SDKModel:_modifyTrackDefine_EventName()
	local e = SDKDataTrackMgr.EventName

	e.summon_client = "summon_client"
end

function SDKModel:_modifyTrackDefine_EventProperties()
	local e = SDKDataTrackMgr.EventProperties

	e.poolid = "poolid"
	e.entrance = "entrance"
	e.position_list = "position_list"
end

function SDKModel:_modifyTrackDefine_PropertyTypes()
	local e = SDKDataTrackMgr.PropertyTypes
	local p = SDKDataTrackMgr.EventProperties

	e[p.poolid] = "number"
	e[p.entrance] = "string"
	e[p.position_list] = "string"
end

function SDKModel:isSteam_GL()
	return self._isSteam_GL
end

function SDKModel:isSteam_JP()
	return self._isSteam_JP
end

function SDKModel:isSteam()
	return self:isSteam_GL() or self:isSteam_JP()
end

function SDKModel:isPC()
	return BootNativeUtil.isWindows() or self:isDmm() or self:isSteam()
end

SDKModel.instance = SDKModel.New()

return SDKModel
