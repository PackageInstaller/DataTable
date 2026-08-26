-- chunkname: @modules/logic/partycloth/view/item/PartyClothSuitItem.lua

module("modules.logic.partycloth.view.item.PartyClothSuitItem", package.seeall)

local PartyClothSuitItem = class("PartyClothSuitItem", ListScrollCell)

function PartyClothSuitItem:initInternal(go, view)
	PartyClothSuitItem.super.initInternal(self, go, view)

	self.goEmpty = gohelper.findChild(go, "Empty")
	self.goFinish = gohelper.findChild(go, "Normal/go_Finish")
	self.goSelect = gohelper.findChild(go, "Normal/go_Select")
	self.goSpine = gohelper.findChild(go, "Normal/go_Spine")
	self.txtName = gohelper.findChildText(go, "Normal/txt_Name")
	self.txtProgress = gohelper.findChildText(go, "Normal/txt_Progress")
	self.btnClick = gohelper.findChildButton(go, "Normal/bg")
	self.goClothItem = gohelper.findChild(go, "Normal/Scroll_Cloth/Viewport/Content/clothitem")

	self.addClickCb(self, self.btnClick, self.onClick, self)

	self.spine = PartyGameGuiSpine.Create(self.goSpine)

	local goParent = view.viewName == ViewName.PartyClothView and gohelper.findChild(view.viewGO, "#go_UI/Right/#scroll_Suit") or gohelper.findChild(view.viewGO, "Left/#scroll_Suit")
	local goScroll = gohelper.findChildScrollRect(go, "Normal/Scroll_Cloth")
	local limitScroll = goScroll:GetComponent(gohelper.Type_LimitedScrollRect)

	limitScroll.parentGameObject = goParent
	self.childItem = {}

	for i = 1, 5 do
		local cloneGo = gohelper.cloneInPlace(self.goClothItem)

		self.childItem[i] = MonoHelper.addNoUpdateLuaComOnceToGo(cloneGo, PartyClothSuitChildItem)
	end

	gohelper.setActive(self.goClothItem, false)
end

function PartyClothSuitItem:onUpdateMO(mo)
	self.config = mo.config

	if self.config then
		self.txtName.text = self.config.name
		self.clothCfgs = PartyClothConfig.instance:getClothCfgsBySuit(self.config.id)

		for i = 1, 5 do
			local item = self.childItem[i]
			local config = self.clothCfgs[i]

			if config then
				item:setData(config)
				gohelper.setActive(item.go, true)
			else
				gohelper.setActive(item.go, false)
			end
		end

		local count = PartyClothModel.instance:getSuitCollectCount(self.config.id)

		self.txtProgress.text = string.format("%s/%s", count, #self.clothCfgs)

		gohelper.setActive(self.goFinish, count == #self.clothCfgs)

		local clothIdMap = PartyClothHelper.GetSuitClothIdMap(self.config.id)
		local skinResMap = PartyClothConfig.instance:getSkinRes(clothIdMap)

		self.spine:setSkin(skinResMap)

		if not self.spine:getResPath() then
			self.spine:setResPath(PartyGameEnum.PartyGameUISpineRes)
		end
	end
end

function PartyClothSuitItem:onSelect(isSelect)
	self.isSelect = isSelect

	gohelper.setActive(self.goSelect, isSelect)
end

function PartyClothSuitItem:onClick()
	if self.config and not self.isSelect then
		PartyClothController.instance:dispatchEvent(PartyClothEvent.ClickClothSuitItem, self.config.id)
	end
end

return PartyClothSuitItem
