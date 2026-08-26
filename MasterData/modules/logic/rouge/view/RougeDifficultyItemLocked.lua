-- chunkname: @modules/logic/rouge/view/RougeDifficultyItemLocked.lua

module("modules.logic.rouge.view.RougeDifficultyItemLocked", package.seeall)

local RougeDifficultyItemLocked = class("RougeDifficultyItemLocked", RougeDifficultyItem_Base)

function RougeDifficultyItemLocked:onInitView()
	self._goBg1 = gohelper.findChild(self.viewGO, "bg/#go_Bg1")
	self._goBg2 = gohelper.findChild(self.viewGO, "bg/#go_Bg2")
	self._goBg3 = gohelper.findChild(self.viewGO, "bg/#go_Bg3")
	self._txtnum1 = gohelper.findChildText(self.viewGO, "num/#txt_num1")
	self._txtnum2 = gohelper.findChildText(self.viewGO, "num/#txt_num2")
	self._txtnum3 = gohelper.findChildText(self.viewGO, "num/#txt_num3")
	self._txtname = gohelper.findChildText(self.viewGO, "#txt_name")
	self._txten = gohelper.findChildText(self.viewGO, "#txt_name/#txt_en")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeDifficultyItemLocked:addEvents()
	return
end

function RougeDifficultyItemLocked:removeEvents()
	return
end

function RougeDifficultyItemLocked:_editableInitView()
	RougeDifficultyItem_Base._editableInitView(self)

	self._txtLocked = gohelper.findChildText(self.viewGO, "lock/txt_locked")
end

function RougeDifficultyItemLocked:setData(mo)
	RougeDifficultyItem_Base.setData(self, mo)

	local difficultyCO = mo.difficultyCO
	local preDifficulty = difficultyCO.preDifficulty

	if preDifficulty and preDifficulty > 0 then
		local cfg = RougeOutsideModel.instance:config()
		local preDifficultyCO = cfg:getDifficultyCO(preDifficulty)

		self._txtLocked.text = formatLuaLang("rougedifficultyitemlocked_unlock_desc_fmt", preDifficultyCO.title)
	else
		self._txtLocked.text = ""
	end
end

return RougeDifficultyItemLocked
