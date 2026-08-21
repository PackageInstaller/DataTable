-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/widgets/RogueEquipTips.lua

module("logic.extensions.roguelike.view.widgets.RogueEquipTips", package.seeall)

local M = class("RogueEquipTips")

function M:ctor(container)
	local go = container.gameObject

	self._go = go
	self._txtName = goutil.findChildTextComponent(go, "txtName")
	self._txtPassiveDesc = RogueEquipDescBox.New(goutil.findChild(go, "scroll/view/content/content1"))
	self._txtProactiveDesc = RogueEquipDescBox.New(goutil.findChild(go, "scroll/view/content/content2"))
	self._imgIcon = goutil.findChildImageComponent(go, "equitIcon")
	self._imgQua = goutil.findChildImageComponent(go, "mask/imgQuality")
	self._btnUse = UIComponentType.ButtonAdapter(goutil.findChild(go, "btnUse"))
	self._txtUse = goutil.findChildTextComponent(go, "btnUse/Text")
	self._btnClose = UIComponentType.ButtonAdapter(goutil.findChild(go, "btnClose"))
	self._btnExplain = UIComponentType.ButtonAdapter(goutil.findChild(go, "btn_explain"))

	self._btnUse:AddClickListener(self.onBtnUse, self)
	self._btnClose:AddClickListener(self.onBtnClose, self)
	self._btnExplain:AddClickListener(self.onBtnExplain, self)
end

function M:updateData(data)
	self._txtName.text = data:getName()

	local equipCo = RoguelikeConfig.instance:getEquipById(data:getId(), data:getLevel())

	self._txtPassiveDesc:upadateData(equipCo.passiveEffectDescription)
	self._txtProactiveDesc:upadateData(equipCo.activeEffectDescription)
	IconLoader.setSprite(self._imgIcon, IconType.ItemIcon, data:getIcon())

	self._mo = data
	self._txtUse.text = data:getCd() ~= 0 and lang("tip_r_equip_using") or lang("tip_r_equip_use")

	self:setActive(true)
end

function M:setActive(isActive)
	goutil.setActive(self._go, isActive)
end

function M:OnDestroy()
	self._btnUse:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnExplain:RemoveClickListener()
end

function M:onBtnUse()
	local cd = self._mo:getCd()

	if cd ~= 0 then
		FloatWordMgr.instance:show(lang("tip_r_equip_skill_in_cd"))

		return
	end

	RoguelikeController.instance:useSkill()
	self:setActive(false)
end

function M:onBtnClose()
	self:setActive(false)
end

function M:onBtnExplain()
	ViewMgr.instance:open(ViewName.ImageGuide, {
		CommEnum.ManualKey.RogueEquipTips
	})
end

return M
