-- chunkname: @modules/logic/survival/view/handbook/SurvivalHandbookEventItem.lua

module("modules.logic.survival.view.handbook.SurvivalHandbookEventItem", package.seeall)

local SurvivalHandbookEventItem = class("SurvivalHandbookEventItem", LuaCompBase)

function SurvivalHandbookEventItem:init(go)
	self.go = go
	self.animGo = gohelper.findComponentAnim(go)
	self.empty = gohelper.findChild(go, "#empty")
	self.normal = gohelper.findChild(go, "#normal")
	self.txt_Title = gohelper.findChildTextMesh(go, "#normal/Title/#txt_Title")
	self.image_model_obj = gohelper.findChild(go, "#normal/#image_model")
	self.image_model = self.image_model_obj:GetComponent(gohelper.Type_RawImage)
	self.txt_Descr = gohelper.findChildTextMesh(go, "#normal/#txt_Descr")
	self.btnLeftArrow = gohelper.findChildButtonWithAudio(go, "#normal/#btnLeftArrow")
	self.btnRightArrow = gohelper.findChildButtonWithAudio(go, "#normal/#btnRightArrow")
	self.txt_Num = gohelper.findChildTextMesh(go, "#normal/#txt_Num")
	self.refreshFlow = FlowSequence.New()

	self.refreshFlow:addWork(TimerWork.New(0.167))
	self.refreshFlow:addWork(FunctionWork.New(self.refreshDesc, self))
end

function SurvivalHandbookEventItem:getItemAnimators()
	return {
		self.animGo
	}
end

function SurvivalHandbookEventItem:onStart()
	self.curSelectIndex = 1
end

function SurvivalHandbookEventItem:addEventListeners()
	self.addClickCb(self, self.btnLeftArrow, self.onClickLeft, self)
	self.addClickCb(self, self.btnRightArrow, self.onClickRight, self)
end

function SurvivalHandbookEventItem:removeEventListeners()
	self:removeClickCb(self.btnLeftArrow)
	self:removeClickCb(self.btnRightArrow)
end

function SurvivalHandbookEventItem:onDestroyView()
	self.refreshFlow:clearWork()
end

function SurvivalHandbookEventItem:setSurvivalHandbookEventComp(survivalHandBookEventComp)
	self.survivalHandBookEventComp = survivalHandBookEventComp
end

function SurvivalHandbookEventItem:updateMo(mo)
	self.mo = mo

	if not self.mo.isUnlock then
		gohelper.setActive(self.empty, true)
		gohelper.setActive(self.normal, false)

		return
	end

	gohelper.setActive(self.empty, false)
	gohelper.setActive(self.normal, true)

	self.txt_Title.text = mo:getName()

	if not self.survivalUI3DRender then
		local width = recthelper.getWidth(self.image_model.transform)
		local height = recthelper.getHeight(self.image_model.transform)

		self.survivalUI3DRender = self.survivalHandBookEventComp:popSurvivalUI3DRender(width, height)
		self.image_model.texture = self.survivalUI3DRender:getRenderTexture()
	end

	self.survival3DModelMO = self.survival3DModelMO or Survival3DModelMO.New()

	local eventId = self.mo:getEventShowId()

	self.survival3DModelMO:setDataByEventID(eventId)
	self.survivalUI3DRender:setSurvival3DModelMO(self.survival3DModelMO)

	local desc = mo:getDesc()

	self.descIndex = 1
	self.textMeshProW = recthelper.getWidth(self.txt_Descr.rectTransform)
	self.textMeshProH = recthelper.getHeight(self.txt_Descr.rectTransform)
	self.descList = {}

	local curStr = desc
	local curIndex = 0
	local len = GameUtil.utf8len(curStr)

	for i = 1, len - 1 do
		curIndex = curIndex + 1

		local newStr = GameUtil.utf8sub(curStr, 1, curIndex)
		local sizeDesc = self.txt_Descr:GetPreferredValues(newStr, self.textMeshProW, self.textMeshProH)
		local newH = sizeDesc.y

		if newH > self.textMeshProH then
			local insertStr = GameUtil.utf8sub(curStr, 1, curIndex - 1)

			table.insert(self.descList, insertStr)

			curStr = GameUtil.utf8sub(curStr, curIndex, len - curIndex + 1)
			curIndex = 1
		elseif i == len - 1 then
			local insertStr = GameUtil.utf8sub(curStr, 1, curIndex + 1)

			table.insert(self.descList, insertStr)
		end
	end

	self:refreshDesc()
end

function SurvivalHandbookEventItem:onDisable()
	if self.survivalUI3DRender then
		self.survivalHandBookEventComp:pushSurvivalUI3DRender(self.survivalUI3DRender)

		self.survivalUI3DRender = nil
	end
end

function SurvivalHandbookEventItem:onDestroy()
	if self.survivalUI3DRender then
		UI3DRenderController.instance.removeSurvivalUI3DRender(self.survivalUI3DRender)

		self.survivalUI3DRender = nil
	end
end

function SurvivalHandbookEventItem:onClickLeft()
	if self.descIndex > 1 then
		self.descIndex = self.descIndex - 1
	end

	self.animGo:Play(UIAnimationName.Switch, 0, 0)
	self.refreshFlow:clearWork()
	self.refreshFlow:start()
end

function SurvivalHandbookEventItem:onClickRight()
	if self.descIndex < #self.descList then
		self.descIndex = self.descIndex + 1
	end

	self.animGo:Play(UIAnimationName.Switch, 0, 0)
	self.refreshFlow:clearWork()
	self.refreshFlow:start()
end

function SurvivalHandbookEventItem:refreshBtnArrow()
	if self.descIndex <= 1 then
		gohelper.setActive(self.btnLeftArrow, false)
	else
		gohelper.setActive(self.btnLeftArrow, true)
	end

	if self.descIndex >= #self.descList then
		gohelper.setActive(self.btnRightArrow, false)
	else
		gohelper.setActive(self.btnRightArrow, true)
	end

	if #self.descList > 1 then
		gohelper.setActive(self.txt_Num.gameObject, true)

		self.txt_Num.text = string.format("%s/%s", self.descIndex, #self.descList)
	else
		gohelper.setActive(self.txt_Num.gameObject, false)
	end
end

function SurvivalHandbookEventItem:refreshDesc()
	self:refreshBtnArrow()

	self.txt_Descr.text = self.descList[self.descIndex]
end

return SurvivalHandbookEventItem
