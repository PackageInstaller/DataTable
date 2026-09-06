-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/view/stack/PetshowruneView.lua

module("logic.extensions.bag.view.stack.PetshowruneView", package.seeall)

local PetshowruneView = class("PetshowruneView", ViewComponent)

function PetshowruneView:ctor()
	PetshowruneView.super.ctor(self)
end

function PetshowruneView:buildUI()
	PetshowruneView.super.buildUI(self)

	self._empty = self:getGo("empty")
	self._notnull = self:getGo("notnull")
	self._runeSuitItem = RuneSuitItem.New(goutil.findChild(self._notnull, "runesuititem"))
	self._btnSelect = self:getBtn("empty/btnSelect")
	self._btnChange = self:getBtn("notnull/btnChange")
	self._btnEdit = self:getBtn("notnull/btnEdit")
	self._runeTipsPoint = self:getGo("runeTipsPoint")
end

function PetshowruneView:bindEvents()
	PetshowruneView.super.bindEvents(self)
	self._btnSelect:AddClickListener(self.onSelect, self)
	self._btnChange:AddClickListener(self.onSelect, self)
	self._btnEdit:AddClickListener(self.onEdit, self)
end

function PetshowruneView:unbindEvents()
	PetshowruneView.super.unbindEvents(self)
	self._btnSelect:RemoveClickListener()
	self._btnChange:RemoveClickListener()
	self._btnEdit:RemoveClickListener()
end

function PetshowruneView:destroyUI()
	PetshowruneView.super.destroyUI(self)
end

function PetshowruneView:onEnter()
	PetshowruneView.super.onEnter(self)
	GameUtil.SetActive(self.mainGO, false)
	RuneController.instance:getSuitInfo(GameUtil.handler(self.onUpdateData, self))
end

function PetshowruneView:onUpdateData()
	GameUtil.SetActive(self.mainGO, true)
	self:refresh()
	GlobalDispatcher:addListener(GlobalNotify.OnPetSelect, self.refresh, self)
end

function PetshowruneView:onEnterFinished()
	PetshowruneView.super.onEnterFinished(self)
end

function PetshowruneView:onExit()
	PetshowruneView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.OnPetSelect, self.refresh, self)
end

function PetshowruneView:onExitFinished()
	PetshowruneView.super.onExitFinished(self)
end

function PetshowruneView:refresh()
	self.curMo = BagPetsController.instance:GetCurPetMo()
	self.suitId = self.curMo.runeSuit.runeSuitId
	self.suitMo = RuneModel.instance:getSuitMo(self.suitId)

	if self.suitMo ~= nil then
		self.slots = self.suitMo.slots
	end

	if self.curMo.runeSuit then
		local isHasSuit = self.curMo.runeSuit.runeSuitId ~= -1

		goutil.setActive(self._notnull, isHasSuit)
		goutil.setActive(self._empty, not isHasSuit)

		local runeMos = {}

		for i = 1, RuneConfig.MAX_RUNE_SLOT_COUNT do
			if self.slots ~= nil and self.slots[i - 1] ~= nil then
				runeMos[i] = RuneModel.instance:getItemData(self.slots[i - 1].runeId)
			end
		end

		if isHasSuit then
			self._runeSuitItem:onSetMo(self.suitId, runeMos)
			self._runeSuitItem:setClickRuneSlotCall(self._onClickRuneSlot, self)
		end
	end
end

function PetshowruneView:refreshSuit()
	self.txtTitle.text = ""
	self.txtDesc.text = ""
	self.txtExt.text = ""

	GameUtil.setAnchoredPos(self.txtExt, 0, 0)

	self.slots = {}

	if self.suitMo then
		self.slots = self.suitMo.slots

		local cf = RuneConfig.instance:getSuitById(self.suitMo.suitId)

		self.txtTitle.text = cf.name

		local lvl, tem, count = self.suitMo:getCurLvl()

		self.txtTitle.text = cf.name .. " Lv." .. lvl
		self.txtDesc.text = lvl > 0 and tem ~= nil and "灵能等级：" .. count .. "\n" .. RuneConfig.instance:propToString({
			tem.propertyApp
		}) or "灵能等级：" .. count .. "\n无额外属性"
	end

	for i, v in ipairs(self.items) do
		local slotmo

		self:setItem(v, (self.slots or nil) and self.slots[i - 1])
	end
end

function PetshowruneView:_onClickRuneSlot(idx)
	local slotmo = self.slots[idx - 1]
	local runeMo

	if slotmo then
		runeMo = RuneModel.instance:getItemData(slotmo.runeId)

		local btnText = "升级"

		local function btnCall()
			print("点击升级")
		end

		local x, y, z = Framework.TransformUtil.GetPos(self._runeTipsPoint.transform, 0, 0, 0)

		UIStateManager.instance:open(ViewName.CommonRuneTips, runeMo, {
			x,
			y,
			z
		}, {
			{
				btnText = btnText,
				btnCall = btnCall
			}
		})
	end
end

function PetshowruneView:onSelect()
	RuneController.instance:putonSuit(self.curMo, self.suitMo)
end

function PetshowruneView:onEdit()
	RuneController.instance:openMainView(self.curMo.runeSuit.runeSuitId)
end

function PetshowruneView:onExt()
	CommonTipsMgr.instance:_openOneView(ViewName.RuneitemView, self.suitMo)
end

return PetshowruneView
