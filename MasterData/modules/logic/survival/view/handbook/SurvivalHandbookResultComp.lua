-- chunkname: @modules/logic/survival/view/handbook/SurvivalHandbookResultComp.lua

module("modules.logic.survival.view.handbook.SurvivalHandbookResultComp", package.seeall)

local SurvivalHandbookResultComp = class("SurvivalHandbookResultComp", SurvivalHandbookViewComp)

function SurvivalHandbookResultComp:ctor(parentView)
	self._parentView = parentView
	self.handBookType = SurvivalEnum.HandBookType.Result
	self.items = {}
end

function SurvivalHandbookResultComp:init(go)
	SurvivalHandbookResultComp.super.init(self, go)

	self.content = gohelper.findChild(go, "#scroll/viewport/content")
	self.SurvivalHandbookResultItem = gohelper.findChild(go, "#scroll/SurvivalHandbookResultItem")

	gohelper.setActive(self.SurvivalHandbookResultItem, false)
end

function SurvivalHandbookResultComp:onStart()
	self:refresh()
	self:playAnim()
	SurvivalHandbookController.instance:markNewHandbook(self.handBookType)
end

function SurvivalHandbookResultComp:addEventListeners()
	return
end

function SurvivalHandbookResultComp:removeEventListeners()
	return
end

function SurvivalHandbookResultComp:onDestroy()
	return
end

function SurvivalHandbookResultComp:onOpen()
	self:playAnim()
end

function SurvivalHandbookResultComp:refresh()
	local datas = SurvivalHandbookModel.instance.resultMos

	table.sort(datas, SurvivalHandbookModel.instance.handBookSortFuncById)

	for i, v in ipairs(datas) do
		local mo = datas[i]
		local obj = gohelper.clone(self.SurvivalHandbookResultItem, self.content)

		gohelper.setActive(obj, true)

		local survivalHandbookResultItem = MonoHelper.addNoUpdateLuaComOnceToGo(obj, SurvivalHandbookResultItem)

		survivalHandbookResultItem:setData({
			mo = mo
		})
		table.insert(self.items, survivalHandbookResultItem)
	end
end

function SurvivalHandbookResultComp:playAnim()
	for i, survivalHandbookResultItem in ipairs(self.items) do
		local animator = survivalHandbookResultItem:getAnimator()
		local openAnimTime = 0.03 * (i - 1)
		local currentAnimatorStateInfo = animator:GetCurrentAnimatorStateInfo(0)
		local length = currentAnimatorStateInfo.length
		local nor = (0 - openAnimTime) / length

		animator:Play(UIAnimationName.Open, 0, nor)
		animator:Update(0)
	end
end

return SurvivalHandbookResultComp
