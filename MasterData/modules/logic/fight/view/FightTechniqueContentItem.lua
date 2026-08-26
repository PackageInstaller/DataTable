-- chunkname: @modules/logic/fight/view/FightTechniqueContentItem.lua

module("modules.logic.fight.view.FightTechniqueContentItem", package.seeall)

local FightTechniqueContentItem = class("FightTechniqueContentItem", LuaCompBase)

function FightTechniqueContentItem:init(go)
	self.go = go
	self._img1 = gohelper.findChildSingleImage(go, "#go_content/#simage_icon1")
	self._img2 = gohelper.findChildSingleImage(go, "#go_content/#simage_icon2")
	self._txtBottomDesc1 = gohelper.findChildText(go, "#txt_bottomdesc1")
	self._txtBottomDesc2 = gohelper.findChildText(go, "#txt_bottomdesc2")
	self._customGODict = self:getUserDataTb_()

	local customParentGO = gohelper.findChild(go, "#go_customList")
	local customParentTr = customParentGO.transform
	local childCount = customParentTr.childCount

	for i = 1, childCount do
		local childTr = customParentTr:GetChild(i - 1)
		local id = tonumber(childTr.name)

		if id then
			self._customGODict[id] = childTr.gameObject
		end
	end
end

function FightTechniqueContentItem:updateItem(param)
	self._index = param.index
	self._id = param.id

	transformhelper.setLocalPos(self.go.transform, param.pos, 0, 0)

	local co = lua_fight_technique.configDict[self._id]

	self._txtBottomDesc1.text = co.content1
	self._txtBottomDesc2.text = co.content2

	for id, customGO in pairs(self._customGODict) do
		gohelper.setActive(customGO, self._id == id)
	end
end

function FightTechniqueContentItem:setSelect(index)
	local isSelect = self._index == index

	if isSelect then
		local co = lua_fight_technique.configDict[self._id]

		if not string.nilorempty(co.picture1) then
			self._img1:LoadImage(ResUrl.getFightIcon(co.picture1) .. ".png")
		end

		if not string.nilorempty(co.picture2) then
			self._img2:LoadImage(ResUrl.getFightIcon(co.picture2) .. ".png")
		end

		gohelper.setActive(self.go, true)
		TaskDispatcher.cancelTask(self._hideGO, self)
	elseif self.go.activeInHierarchy then
		TaskDispatcher.runDelay(self._hideGO, self, 0.25)
	end
end

function FightTechniqueContentItem:_hideGO()
	gohelper.setActive(self.go, false)
end

function FightTechniqueContentItem:onDestroy()
	TaskDispatcher.cancelTask(self._hideGO, self)

	if self._img1 then
		self._img1:UnLoadImage()
		self._img2:UnLoadImage()

		self._img1 = nil
		self._img2 = nil
	end
end

return FightTechniqueContentItem
