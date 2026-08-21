-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/viewlib/item/impl/BuffDetailItem1.lua

module("logic.common.viewlib.item.impl.BuffDetailItem1", package.seeall)

local M = class("BuffDetailItem1", UIReusableLuaBehavior)
local kLayerFormat = "<color=#FFFFFF>%s</color>/5层"

function M:buildUI()
	self._imgBgIcon = goutil.findChildImageComponent(self.mainGO, "imgBuffDi")
	self._imgIcon = goutil.findChildImageComponent(self.mainGO, "icon")
	self._txtName = goutil.findChildTextComponent(self.mainGO, "txtBuffName")
	self._txtContent = goutil.findChildComponent(self.mainGO, "content", UIComponentType.TextMeshProUGUI)
	self._goRound = goutil.findChild(self.mainGO, "countdown")
	self._txtRound = goutil.findChildTextComponent(self.mainGO, "countdown/text")
	self._goLayer = goutil.findChild(self.mainGO, "countLayer")
	self._txtLayer = goutil.findChildTextComponent(self.mainGO, "countLayer/text")
end

function M:destroyUI()
	self._imgIcon = nil
	self._txtName = nil
	self._txtContent = nil
	self._goRound = nil
	self._txtRound = nil
	self._goLayer = nil
	self._txtLayer = nil
end

function M:onEnter()
	return
end

function M:onExit()
	IconLoader.clearSprite(self._imgIcon)
end

function M:setBuffId(buffId)
	local buffCO = BuffConfig.instance:getBuffCO(buffId)

	self._txtName.text = buffCO.name

	local contentStr = ActiveSkillCOUtil.buildBuffAndTagDesc(buffCO.desc)

	contentStr = ActiveSkillCOUtil.replaceDescriptionSpecialColor(contentStr)
	self._txtContent.text = contentStr

	IconLoader.setSprite(self._imgIcon, IconType.BuffIcon, buffCO.buffIcon)
	IconLoader.setSprite(self._imgBgIcon, IconType.Skinlib, BuffCOUtil.getBuffIconBgOfTips(buffCO))
	goutil.setActive(self._goLayer, false)
end

function M:setRound(round)
	goutil.setActive(self._goRound, true)

	if round >= 0 then
		self._txtRound.text = string.format(lang("t_buff_detail_item_round_format"), round)
	else
		self._txtRound.text = "∞"
	end
end

function M:setLayerAndMaxLayer(layer, maxLayer)
	if layer > 0 then
		goutil.setActive(self._goLayer, true)

		self._txtLayer.text = string.format(lang("t_buff_detail_item_layer_format"), layer, maxLayer)
	end
end

return M
