-- chunkname: @modules/logic/handbook/controller/HandbookController.lua

module("modules.logic.handbook.controller.HandbookController", package.seeall)

local HandbookController = class("HandbookController", BaseController)

HandbookController.EventName = {
	PlayCharacterSwitchCloseAnim = 3,
	PlayCharacterSwitchOpenAnim = 2,
	OnShowSubCharacterView = 1
}
HandbookController.OpenViewNameEnum = {
	HandbookCharacterView = 1,
	HandbookStoryView = 3,
	HandbookEquipView = 2
}

function HandbookController:onInit()
	self._openViewName = 0
	self._isDelaySendUnlockSkinRedDotInfoList = {}
end

function HandbookController:reInit()
	self._openViewName = 0
	self._isDelaySendUnlockSkinRedDotInfoList = {}
end

function HandbookController:addConstEvents()
	MainController.instance:registerCallback(MainEvent.OnFirstEnterMain, self.initHandbookRedDot, self)
	PlayerController.instance:registerCallback(PlayerEvent.UpdateSimpleProperty, self.onUpdateSimpleProperty, self)
end

function HandbookController:jumpView(param)
	local remainViewNames = {}

	self:openView()

	if #param <= 1 then
		return remainViewNames
	end

	local viewType = tonumber(param[2])

	if viewType == JumpEnum.HandbookType.Character then
		self:openCharacterView()
		table.insert(remainViewNames, ViewName.HandBookCharacterSwitchView)
	elseif viewType == JumpEnum.HandbookType.Equip then
		self:openEquipView()
		table.insert(remainViewNames, HandbookEquipView)
	elseif viewType == JumpEnum.HandbookType.Story then
		local chapter = tonumber(param[3])

		if chapter then
			self:openStoryView(chapter)
		else
			self:openStoryView()
		end

		table.insert(remainViewNames, HandbookStoryView)
	elseif viewType == JumpEnum.HandbookType.CG then
		self:openCGView()
		table.insert(remainViewNames, HandbookCGView)
	elseif viewType == JumpEnum.HandbookType.Skin then
		self:openHandbookSkinView()
	end

	return remainViewNames
end

function HandbookController:openView(param)
	self:markNotFirstHandbook()
	ViewMgr.instance:openView(ViewName.HandbookView, param)
end

function HandbookController:openCharacterView(param)
	self._openViewParam = param
	self._openViewName = HandbookController.OpenViewNameEnum.HandbookCharacterView

	HandbookRpc.instance:sendGetHandbookInfoRequest(self._getHandbookInfoReply, self)
end

function HandbookController:openEquipView(param)
	self._openViewParam = param
	self._openViewName = HandbookController.OpenViewNameEnum.HandbookEquipView

	HandbookRpc.instance:sendGetHandbookInfoRequest(self._getHandbookInfoReply, self)
end

function HandbookController:openStoryView(param)
	self._openViewParam = param
	self._openViewName = HandbookController.OpenViewNameEnum.HandbookStoryView

	HandbookRpc.instance:sendGetHandbookInfoRequest(self._getHandbookInfoReply, self)
end

function HandbookController:_getHandbookInfoReply()
	self.viewNameDict = self.viewNameDict or {
		[HandbookController.OpenViewNameEnum.HandbookCharacterView] = ViewName.HandBookCharacterSwitchView,
		[HandbookController.OpenViewNameEnum.HandbookEquipView] = ViewName.HandbookEquipView,
		[HandbookController.OpenViewNameEnum.HandbookStoryView] = ViewName.HandbookStoryView
	}

	ViewMgr.instance:openView(self.viewNameDict[self._openViewName], self._openViewParam)

	self._openViewParam = nil
end

function HandbookController:openCGView(param)
	ViewMgr.instance:openView(ViewName.HandbookCGView, param)
end

function HandbookController:openCGDetailView(param)
	ViewMgr.instance:openView(ViewName.HandbookCGDetailView, param)
end

function HandbookController:markNotFirstHandbook()
	local userId = PlayerModel.instance:getMyUserId()
	local key = PlayerPrefsKey.FirstHandbook .. tostring(userId)

	PlayerPrefsHelper.setNumber(key, 1)
end

function HandbookController:isFirstHandbook()
	local userId = PlayerModel.instance:getMyUserId()
	local key = PlayerPrefsKey.FirstHandbook .. tostring(userId)

	return PlayerPrefsHelper.getNumber(key, 0) <= 0
end

function HandbookController:markNotFirstHandbookSkin()
	local userId = PlayerModel.instance:getMyUserId()
	local key = PlayerPrefsKey.FirstSkinHandbook3_0 .. tostring(userId)

	PlayerPrefsHelper.setNumber(key, 1)
	self:dispatchEvent(HandbookEvent.EnterHandbookSkin)
end

function HandbookController:isFirstHandbookSkin()
	local userId = PlayerModel.instance:getMyUserId()
	local key = PlayerPrefsKey.FirstSkinHandbook3_0 .. tostring(userId)

	return PlayerPrefsHelper.getNumber(key, 0) <= 0
end

function HandbookController:hasAnyHandBookSkinGroupRedDot()
	local skinRedDotInfo = HandbookModel.instance:getAllSkinRedDotInfo()

	if skinRedDotInfo and next(skinRedDotInfo) then
		return true
	end

	local skinRedDotUnlockInfo = HandbookModel.instance:getAllSkinUnlockRedDotInfo()

	if skinRedDotUnlockInfo and next(skinRedDotUnlockInfo) then
		return true
	end

	for groupId, _ in pairs(HandbookEnum.HandbookSkinShowRedDotMap) do
		if self:isHandbookSkinRedDotShow(groupId) then
			return true
		end
	end

	return false
end

function HandbookController:markHandbookSkinRedDotShow(skinGroupId)
	if skinGroupId then
		return
	end

	local userId = PlayerModel.instance:getMyUserId()
	local key = PlayerPrefsKey.FirstSkinHandbookSuit .. tostring(skinGroupId) .. tostring(userId)

	PlayerPrefsHelper.setNumber(key, 1)
	self:dispatchEvent(HandbookEvent.MarkHandbookSkinSuitRedDot)
end

function HandbookController:isHandbookSkinRedDotShow(skinGroupId)
	if skinGroupId then
		return false
	end

	local userId = PlayerModel.instance:getMyUserId()
	local key = PlayerPrefsKey.FirstSkinHandbookSuit .. tostring(skinGroupId) .. tostring(userId)

	return PlayerPrefsHelper.getNumber(key, 0) <= 0
end

function HandbookController:isHandbookSkinGroupNewRedDotShow(skinGroupId)
	local skinRedDotInfo = HandbookModel.instance:getSkinRedDotInfo(skinGroupId)
	local skinUnlockRedDotInfo = HandbookModel.instance:getSkinUnlockRedDotInfo(skinGroupId)

	return skinRedDotInfo and next(skinRedDotInfo) or skinUnlockRedDotInfo and next(skinUnlockRedDotInfo)
end

function HandbookController:isHandbookSkinSuitNewRedDotShow(suitId)
	local suitConfig = HandbookConfig.instance:getSkinSuitCfg(suitId)
	local skinRedDotInfo = HandbookModel.instance:getSkinRedDotInfo(suitConfig.highId)
	local skinUnlockRedDotInfo = HandbookModel.instance:getSkinUnlockRedDotInfo(suitConfig.highId)

	return (skinRedDotInfo or nil) and (skinRedDotInfo[suitId] or skinUnlockRedDotInfo and skinUnlockRedDotInfo[suitId])
end

function HandbookController:isHandbookSkinUnlockRedDotShow(skinId)
	local skinUnlockReadDic = HandbookModel.instance:getSkinUnlockRedDotReadInfo()
	local suit = HandbookConfig.instance:getSkinSuitIdBySkinId(skinId)

	if skinUnlockReadDic and skinUnlockReadDic[suit] then
		local value = skinUnlockReadDic[suit][skinId]

		return value ~= nil and value == 1
	end

	return false
end

function HandbookController:markHandbookSkinNewRedDotShow(suitId)
	HandbookModel.instance:markHandbookSkinRedDotShow(suitId)

	local param = HandbookModel.instance:getSkinRedDotInfoParam()

	PlayerRpc.instance:sendSetSimplePropertyRequest(PlayerEnum.SimpleProperty.HandBookRedDot, param)
end

function HandbookController:markHandbookSkinUnlockRedDotShow(skinId)
	HandbookModel.instance:markHandbookSkinUnlockRedDotShow(skinId)

	local param = HandbookModel.instance:getSkinRedDotInfoParam()

	PlayerRpc.instance:sendSetSimplePropertyRequest(PlayerEnum.SimpleProperty.HandBookRedDot, param)
end

function HandbookController:onUpdateSimpleProperty(propertyId)
	if propertyId == PlayerEnum.SimpleProperty.HandBookRedDot then
		self:refreshHandbookSkinRedDot()
	end
end

function HandbookController:refreshHandbookSkinRedDot()
	local property = PlayerModel.instance:getSimpleProperty(PlayerEnum.SimpleProperty.HandBookRedDot)
	local param = not string.nilorempty(property) and property or ""

	HandbookModel.instance:updateSkinRedDotInfo(param)
	self:dispatchEvent(HandbookEvent.MarkHandbookSkinSuitRedDot)
end

function HandbookController:initHandbookRedDot()
	self:refreshHandbookSkinRedDot()
end

function HandbookController:getDefaultHandbookSkinGroupId(sortList)
	if not sortList then
		::label_27_0::

		local list = HandbookConfig.instance:getSkinThemeGroupCfgs(true, true)

		if list and next(list) then
			for index, themeConfig in ipairs(list) do
				if self:isHandbookSkinGroupNewRedDotShow(themeConfig.id) then
					return index
				end
			end
		end

		return 1
	end
end

function HandbookController:getDefaultHandbookSkinSuitId(sortList, groupId)
	if not sortList then
		::label_28_0::

		local list = HandbookConfig.instance:getSkinSuitCfgListInGroup(groupId, true)

		if list and next(list) then
			for index, suitCfg in ipairs(list) do
				if HandbookController.instance:isHandbookSkinSuitNewRedDotShow(suitCfg.id) then
					return index
				end
			end
		end

		return 1
	end
end

function HandbookController:onGainHandbookSkin(skinId)
	local suitId = HandbookConfig.instance:getSkinSuitIdBySkinId(skinId)

	if suitId then
		HandbookModel.instance:addOrRemoveUnlockSkinId(skinId, true)

		local param = HandbookModel.instance:getSkinRedDotInfoParam()

		PlayerRpc.instance:sendSetSimplePropertyRequest(PlayerEnum.SimpleProperty.HandBookRedDot, param)
		logNormal("标记套组皮肤 皮肤id:" .. tostring(skinId) .. " 套组id:" .. tostring(suitId) .. " 参数: " .. tostring(param))
	end
end

function HandbookController:delaySendUnlockSkinRedDotInfo(skinId)
	if self._isDelaySendUnlockSkinRedDotInfoList and next(self._isDelaySendUnlockSkinRedDotInfoList) then
		TaskDispatcher.cancelTask(self.onDelaySendUnlockSkinRedDotInfo, self)
	end

	table.insert(self._isDelaySendUnlockSkinRedDotInfoList, skinId)
	TaskDispatcher.runDelay(self.onDelaySendUnlockSkinRedDotInfo, self, 0.1)
end

function HandbookController:onDelaySendUnlockSkinRedDotInfo()
	if self._isDelaySendUnlockSkinRedDotInfoList and next(self._isDelaySendUnlockSkinRedDotInfoList) then
		for _, skinId in ipairs(self._isDelaySendUnlockSkinRedDotInfoList) do
			HandbookModel.instance:addOrRemoveUnlockSkinId(skinId, false)
			logNormal("移除套组皮肤 skinId: " .. tostring(skinId))
		end

		local param = HandbookModel.instance:getSkinRedDotInfoParam()

		tabletool.clear(self._isDelaySendUnlockSkinRedDotInfoList)
		TaskDispatcher.cancelTask(self.onDelaySendUnlockSkinRedDotInfo, self)
		PlayerRpc.instance:sendSetSimplePropertyRequest(PlayerEnum.SimpleProperty.HandBookRedDot, param)
	end
end

function HandbookController:openHandbookWeekWalkMapView(param)
	self._openViewParam = param

	WeekwalkRpc.instance:sendGetWeekwalkEndRequest(self._getWeekWalkEndReply, self)
end

function HandbookController:_getWeekWalkEndReply()
	ViewMgr.instance:openView(ViewName.HandbookWeekWalkMapView, self._openViewParam)

	self._openViewParam = nil
end

function HandbookController:openHandbookSkinView(param)
	ViewMgr.instance:openView(ViewName.HandbookSkinView, param)
end

function HandbookController:statSkinTab(tabId)
	StatController.instance:track(StatEnum.EventName.SkinCollectionTab, {
		[StatEnum.EventProperties.Skin_TabId] = tabId
	})
end

function HandbookController:statSkinSuiteId(suiteId)
	StatController.instance:track(StatEnum.EventName.SkinCollectionTab, {
		[StatEnum.EventProperties.Skin_SuiteId] = suiteId
	})
end

function HandbookController:statSkinSuitDetail(suitId)
	local skinSuitCfg = HandbookConfig.instance:getSkinSuitCfg(suitId)

	if skinSuitCfg then
		StatViewController.instance:track(string.format("%s-%s", StatViewNameEnum.OtherViewName.HandbookSkinSuitDetailView, skinSuitCfg.name or suitId), StatViewNameEnum.OtherViewName.HandbookSkinView)
	end
end

HandbookController.instance = HandbookController.New()

return HandbookController
