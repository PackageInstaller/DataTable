-- chunkname: @modules/logic/rouge/view/RougeDifficultyItem_Base.lua

module("modules.logic.rouge.view.RougeDifficultyItem_Base", package.seeall)

local RougeDifficultyItem_Base = class("RougeDifficultyItem_Base", RougeItemNodeBase)

function RougeDifficultyItem_Base:_editableInitView()
	self._itemClick = gohelper.getClickWithAudio(self.viewGO)
	self._goNumList = self:getUserDataTb_()
	self._txtNumList = self:getUserDataTb_()

	self:_fillUserDataTb("_txtnum", self._goNumList, self._txtNumList)

	self._goBgList = self:getUserDataTb_()

	self:_fillUserDataTb("_goBg", self._goBgList)
end

function RougeDifficultyItem_Base:addEventListeners()
	RougeItemNodeBase.addEventListeners(self)
	self._itemClick:AddClickListener(self._onItemClick, self)
end

function RougeDifficultyItem_Base:removeEventListeners()
	RougeItemNodeBase.removeEventListeners(self)
	GameUtil.onDestroyViewMember_ClickListener(self, "_itemClick")
end

function RougeDifficultyItem_Base:_onItemClick()
	self:dispatchEvent(RougeEvent.RougeDifficultyView_OnSelectIndex, self:index())
end

function RougeDifficultyItem_Base:setData(mo)
	self._mo = mo

	local difficultyCO = mo.difficultyCO
	local difficulty = difficultyCO.difficulty
	local styleIndex = RougeConfig1.instance:getRougeDifficultyViewStyleIndex(difficulty)

	for _, go in ipairs(self._goNumList) do
		gohelper.setActive(go, false)
	end

	gohelper.setActive(self._goNumList[styleIndex], true)

	for _, go in ipairs(self._goBgList) do
		gohelper.setActive(go, false)
	end

	gohelper.setActive(self._goBgList[styleIndex], true)

	self._txtNumList[styleIndex].text = difficulty
	self._txtname.text = difficultyCO.title
	self._txten.text = difficultyCO.title_en
end

return RougeDifficultyItem_Base
