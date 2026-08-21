-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/view/setting/AirWorkSettingConditionItem.lua

module("logic.extensions.airworkshop.flow.defflow.view.setting.AirWorkSettingConditionItem", package.seeall)

local M = class("AirWorkSettingConditionItem")

function M:ctor(container)
	self._go = container.gameObject
	self._txtContent = goutil.findChildTextComponent(self._go, "txtContent")
	self._btnSelect = Astral.ButtonAdapter.Get(goutil.findChild(self._go, "btnSelect"))
	self._btnDelete = Astral.ButtonAdapter.Get(goutil.findChild(self._go, "btnDelete"))
	self._flag1Go = goutil.findChild(self._go, "img1")
	self._flag2Go = goutil.findChild(self._go, "img2")

	self:_bindEvents()
end

function M:_bindEvents()
	self._btnSelect:AddClickListener(self._onClickSelect, self)
	self._btnDelete:AddClickListener(self._onClickDelete, self)
end

function M:_unbindEvents()
	self._btnSelect:RemoveClickListener()
	self._btnDelete:RemoveClickListener()
end

function M:OnDestroy()
	self:_unbindEvents()
end

function M:updateData(data)
	self._data = data

	local co = AirWorkShopConfig.instance:getConfigByKey(ConfigName.AirStudioWinCondition, self._data.id)
	local isKill = self._data.type == AirWorkShopEnum.ConditionType.Kill

	if #self._data.params > 0 then
		if isKill then
			local heroId = self._data.params[1]
			local characterCo = CharacterConfig.instance:getCfgInfoByID(heroId)
			local heroInfoCo = PastInfoConfig.instance:getCharacterInfo(heroId)
			local colorStr = CommEnum.LotteryCardQualityColor[characterCo.quality]

			self._txtContent.text = string.gsub(co.describe, lang("tip_air_condition_card"), string.format("<color=%s>%s</color>", colorStr, heroInfoCo.name))
		else
			self._txtContent.text = lang("tip_air_condition_move")
		end
	else
		self._txtContent.text = co.describe
	end

	local isSet = #self._data.params > 0

	goutil.setActive(self._btnDelete.gameObject, isSet)
	goutil.setActive(self._flag1Go, not isSet)
	goutil.setActive(self._flag2Go, isSet)
end

function M:_onClickDelete()
	printWarn("===_onClickDelete id==>", isOn, self._data.id)

	local param = {}

	param.isDelete = true
	param.id = self._data.id

	GlobalDispatcher:dispatchEvent(EventType.AIRWORKSHOP_CONDITION_CHANGE, param)
end

function M:_onClickSelect()
	if self._data.type == AirWorkShopEnum.ConditionType.Kill then
		ViewMgr.instance:open(ViewName.AirWorkShopSelectHeroView)
	else
		GlobalDispatcher:dispatchEvent(EventType.AIRWORKSHOP_SETTING_GOSELECT, AirWorkShopEnum.DefState.LeavePosSet, self._data.params or {})
		ViewMgr.instance:close(ViewName.AirWorkShopSettingView)
	end
end

return M
