-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Pet\\PetGemChangeShowDlg.lua

local EventConst = require("EventConst")
local PetGemInfoPart = require("UI/Pet/PetGemInfoPart")
local PetGemChangeShowDlg = Class("PetGemChangeShowDlg", UIControls.Window)

function PetGemChangeShowDlg:ctor()
	self.btn1 = UIControls.Button(self, "BgPanel/Option01")

	self.btn1:addEventClick(Functor(self.onClickChoose, self, 1))

	self.select1 = UIControls.Image(self, "BgPanel/Option01/SelectImg")
	self.petGemInfoPart1 = PetGemInfoPart(self, "BgPanel/Option01/AttrPanel")
	self.btn2 = UIControls.Button(self, "BgPanel/Option02")

	self.btn2:addEventClick(Functor(self.onClickChoose, self, 2))

	self.select2 = UIControls.Image(self, "BgPanel/Option02/SelectImg")
	self.petGemInfoPart2 = PetGemInfoPart(self, "BgPanel/Option02/AttrPanel")
	self.btnConfirm = UIControls.Button(self, "BgPanel/BtnConfirm")

	self.btnConfirm:addEventClick(self.onClickBtnConfirm)

	self.slotOnPetGemChange = Slot(self.onPetGemChange, self)
end

function PetGemChangeShowDlg:onOpen()
	PetGemChangeShowDlg.super.onOpen(self)
	EventCenter.addEventListener(EventConst.PET_GEM_CHANGE, self.slotOnPetGemChange)

	self.idx = 2

	self.select2:setVisible(true)
	self.select1:setVisible(false)
end

function PetGemChangeShowDlg:onClose()
	PetGemChangeShowDlg.super.onClose(self)
	EventCenter.removeEventListener(EventConst.PET_GEM_CHANGE, self.slotOnPetGemChange)
end

function PetGemChangeShowDlg:onOpenOver()
	PetGemChangeShowDlg.super.onOpenOver(self)

	if not self.gem1 then
		return
	end

	if self.type == Const.PET_GEM_RERAND_ATTR_TYPE_MAIN then
		self.petGemInfoPart2:playAttrEfx(self.type, 1)
	elseif self.type == Const.PET_GEM_RERAND_ATTR_TYPE_SUB then
		local subAttr1 = self.gem1.subAttr
		local subAttr2 = self.gem2.subAttr

		for idx, attr in ipairs(subAttr2) do
			local attrId = attr.attr_id
			local checkSame = false

			for _, tmpAttr in ipairs(subAttr1) do
				if tmpAttr.attr_id == attrId then
					checkSame = true
				end
			end

			if not checkSame then
				self.petGemInfoPart2:playAttrEfx(self.type, idx)
			end
		end
	end
end

function PetGemChangeShowDlg:setData(gid, type, attrs)
	self.gid = gid
	self.type = type
	self.gem1 = CurAvatar.petGemDic[gid]

	if not self.gem1 then
		return
	end

	self.petGemInfoPart1:setData(self.gem1)

	self.gem2 = {}

	setmetatable(self.gem2, {
		__index = self.gem1
	})

	if type == Const.PET_GEM_RERAND_ATTR_TYPE_MAIN then
		local t = {}

		if attrs and #attrs > 0 then
			table.insert(t, {
				attr_id = attrs[1]
			})
		end

		self.gem2.mainAttr = t
	elseif type == Const.PET_GEM_RERAND_ATTR_TYPE_SUB then
		local t = {}

		if attrs and #attrs > 0 then
			for i = 1, #attrs do
				table.insert(t, {
					attr_id = attrs[i]
				})
			end
		end

		self.gem2.subAttr = t
	end

	self.petGemInfoPart2:setData(self.gem2)
end

function PetGemChangeShowDlg:onClickChoose(idx)
	if self.idx == idx then
		return
	end

	self.idx = idx

	self.select1:setVisible(self.idx == 1)
	self.select2:setVisible(self.idx == 2)
end

function PetGemChangeShowDlg:onClickBtnConfirm()
	local confirmCb = Slot(self.confirmCb, self)

	UIManager.showConfirmWithId(1090, confirmCb)
end

function PetGemChangeShowDlg:confirmCb()
	if self.idx == 2 then
		RPC.petGemSaveAttribute(self.type, self.gid, 1)
	else
		RPC.petGemSaveAttribute(self.type, self.gid, 0)
	end
end

function PetGemChangeShowDlg:onPetGemChange(gid, attrs)
	self:setVisible(false)
end

return PetGemChangeShowDlg
