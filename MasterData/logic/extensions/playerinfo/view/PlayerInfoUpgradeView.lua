-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/PlayerInfoUpgradeView.lua

module("logic.extensions.playerinfo.view.PlayerInfoUpgradeView", package.seeall)

local M = class("PlayerInfoUpgradeView", ViewComponent)
local Data2Img = {
	3,
	2,
	1,
	6,
	5,
	4
}

function M:ctor()
	M.super.ctor(self)

	self._playerCardAttribute = {}
end

function M:buildUI()
	self._txtCount = self:getText("player_info_attribute_use_tips_40248788")
	self._imgDimensionCur = self:getGo("sixdimensioninfo_-492787873"):GetComponent("UIPolygon")
	self._imgDimensionAfter = self:getGo("sixdimensioninfo_-450446229"):GetComponent("UIPolygon")
	self._animation = self:getGo("sixdimensioninfo_-450446229"):GetComponent(ComponentType.Animation)
	self._btnReset = self:getBtn("player_info_attribute_use_tips_-1643387810")
	self._btnEnsure = self:getBtn("player_info_attribute_use_tips_-176822476")
	self._btnProperties = {
		self:getBtn("player_info_attribute_use_tips_-772999777"),
		self:getBtn("player_info_attribute_use_tips_-1630329851"),
		self:getBtn("player_info_attribute_use_tips_-908685489"),
		self:getBtn("player_info_attribute_use_tips_-568159477"),
		self:getBtn("player_info_attribute_use_tips_-1180619273"),
		self:getBtn("player_info_attribute_use_tips_-1525238194")
	}
	self._txtProperties = {
		self:getUIComponent("player_info_attribute_use_tips_-2112167928", UIComponentType.Text),
		self:getUIComponent("player_info_attribute_use_tips_-789310768", UIComponentType.Text),
		self:getUIComponent("player_info_attribute_use_tips_738748184", UIComponentType.Text),
		self:getUIComponent("player_info_attribute_use_tips_-1697079965", UIComponentType.Text),
		self:getUIComponent("player_info_attribute_use_tips_-242520427", UIComponentType.Text),
		self:getUIComponent("player_info_attribute_use_tips_-1532850894", UIComponentType.Text)
	}
	self._txtSixImg = {
		self:getUIComponent("sixdimensioninfo_225940234", UIComponentType.Text),
		self:getUIComponent("sixdimensioninfo_25539782", UIComponentType.Text),
		self:getUIComponent("sixdimensioninfo_-2022783530", UIComponentType.Text),
		self:getUIComponent("sixdimensioninfo_1960798206", UIComponentType.Text),
		self:getUIComponent("sixdimensioninfo_1498076505", UIComponentType.Text),
		self:getUIComponent("sixdimensioninfo_158518875", UIComponentType.Text)
	}
	self._txtSixLevel = {
		self:getText("sixdimensioninfo_-410819544"),
		self:getText("sixdimensioninfo_-1335132831"),
		self:getText("sixdimensioninfo_-2033388935"),
		self:getText("sixdimensioninfo_-605687856"),
		self:getText("sixdimensioninfo_1337588298"),
		self:getText("sixdimensioninfo_-61014096")
	}
end

function M:destroyUI()
	return
end

function M:bindEvents()
	for i = 1, 6 do
		self._btnProperties[i]:AddClickListener(function()
			return self:_onClickAdd(i)
		end, self)
	end

	self._btnReset:AddClickListener(self._onClickReset, self)
	self._btnEnsure:AddClickListener(self._onClickEnsure, self)
	GlobalDispatcher:addEventListener(EventType.PLAYER_ATTRIBUTE_UPGRADE, self._update, self)
end

function M:unbindEvents()
	for i = 1, 6 do
		self._btnProperties[i]:RemoveClickListener()
	end

	self._btnReset:RemoveClickListener()
	self._btnEnsure:RemoveClickListener()

	self._playerCardAttribute = nil
	self._animation = nil

	GlobalDispatcher:removeEventListener(EventType.PLAYER_ATTRIBUTE_UPGRADE, self._update, self)
end

function M:_onClickEnsure()
	local isAdd = false
	local isFull = true

	for i = 1, 6 do
		local pos = Data2Img[i]
		local level = self._playerCardAttribute[i] + self._addPoint[pos]

		isFull = isFull and self._playerCardAttribute[i] == 6

		if self._addPoint[pos] > 0 then
			isAdd = true

			PlayerAgent.instance:sendUpgradePlayerCardAttributeRequest(i, level)

			self._addPoint[pos] = 0
		end
	end

	self._imgDimensionCur:DotweenValue(self._value, 0.3)

	if isFull then
		FloatWordMgr.instance:show(lang("tip_prop_full"))
	elseif not isAdd then
		FloatWordMgr.instance:show(lang("tip_prop_no_select"))
	end

	if isAdd then
		self:close()
	end
end

function M:_onClickReset()
	self:_update()
	self:_setSixImg()
	self._imgDimensionAfter:SetValue(self._value)
end

function M:_update()
	self._count = ItemModel.instance:getItemCountByItemId(1100012)
	self._txtCount.text = langF("tip_prop_count", self._count)

	local info = PlayerModel.instance:getMyPlayerInfo()

	for i = 1, 6 do
		local k = info.attribute[i]
		local pos = Data2Img[k.id]

		self._playerCardAttribute[k.id] = k.level

		goutil.setActive(self._btnProperties[pos].gameObject, k.level < 6)

		self._txtSixImg[pos].text = CommEnum.D6Attr2Name[pos]
		self._txtSixLevel[pos].text = string.format("<color=%s>%s</color>", CommEnum.D6Qua2Color[k.level], CommEnum.D6Qua2Score[k.level])
		self._txtProperties[pos].text = string.format("%s <color=%s>%s</color>", CommEnum.D6Attr2Name[pos], CommEnum.D6Qua2Color[k.level], CommEnum.D6Qua2Score[k.level])
	end
end

function M:onEnter()
	self._addPoint = {}

	self:_update()
	self:_setSixImg()
	PlayerAgent.instance:sendGetPlayerCardInfoRequest(PlayerModel.instance:getId(), true)
end

function M:onExit()
	goutil.setActive(self._imgDimensionAfter.gameObject, false)
end

function M:_setSixImg()
	self._value = {}

	for i = 1, 6 do
		local pos = Data2Img[i]
		local v = self._playerCardAttribute[i]

		self._value[pos] = v / 6
		self._addPoint[i] = 0
		self._txtSixImg[pos].text = CommEnum.D6Attr2Name[pos]
		self._txtSixLevel[pos].text = string.format("<color=%s>%s</color>", CommEnum.D6Qua2Color[v], CommEnum.D6Qua2Score[v])
		self._txtProperties[pos].text = string.format("%s <color=%s>%s</color>", CommEnum.D6Attr2Name[pos], CommEnum.D6Qua2Color[v], CommEnum.D6Qua2Score[v])
	end

	self._imgDimensionCur:SetValue(self._value)
end

function M:_onClickAdd(pos)
	if self._count == 0 then
		FloatWordMgr.instance:show(lang("tip_prop_lack"))

		return
	end

	self._count = self._count - 1

	for i = 1, 6 do
		if pos == i then
			self._value[i] = self._value[i] + 0.16666666666666666
		end
	end

	goutil.setActive(self._imgDimensionAfter.gameObject, true)
	self._imgDimensionAfter:SetValue(self._value)

	self._addPoint[pos] = self._addPoint[pos] + 1

	self:_refreshDetail()
	self._animation:Play("dimension_loop")
end

function M:_refreshDetail()
	self._txtCount.text = langF("tip_prop_count", self._count)

	for i = 1, 6 do
		local pos = Data2Img[i]
		local level = self._playerCardAttribute[i] + self._addPoint[pos]

		goutil.setActive(self._btnProperties[pos].gameObject, level < 6)

		self._txtSixImg[pos].text = CommEnum.D6Attr2Name[pos]
		self._txtSixLevel[pos].text = string.format("<color=%s>%s</color>", CommEnum.D6Qua2Color[level], CommEnum.D6Qua2Score[level])
		self._txtProperties[pos].text = string.format("%s <color=%s>%s</color>", CommEnum.D6Attr2Name[pos], CommEnum.D6Qua2Color[level], CommEnum.D6Qua2Score[level])
	end
end

return M
