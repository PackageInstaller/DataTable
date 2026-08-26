-- chunkname: @modules/logic/survival/view/rewardinherit/survivalrewardselect/SurvivalRewardSelectTab.lua

module("modules.logic.survival.view.rewardinherit.survivalrewardselect.SurvivalRewardSelectTab", package.seeall)

local SurvivalRewardSelectTab = class("SurvivalRewardSelectTab", LuaCompBase)

function SurvivalRewardSelectTab:init(go)
	self.viewGO = go
	self._goselect = gohelper.findChild(self.viewGO, "#go_select")
	self._gonum = gohelper.findChild(self.viewGO, "#go_num")
	self._txtnum = gohelper.findChildText(self.viewGO, "#go_num/#txt_num")
	self._btntab = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_tab")
end

function SurvivalRewardSelectTab:addEventListeners()
	self.addClickCb(self, self._btntab, self.onClickBtnClick, self)
end

function SurvivalRewardSelectTab:setData(data)
	if data == nil then
		return
	end

	self.index = data.index
	self.handbookType = data.handbookType
	self.onClickTabCallBack = data.onClickTabCallBack
	self.onClickTabContext = data.onClickTabContext

	self:refreshAmount()
end

function SurvivalRewardSelectTab:refreshAmount()
	local amount = SurvivalRewardInheritModel.instance:getSelectNum(self.handbookType, nil)

	if amount > 0 then
		gohelper.setActive(self._gonum, true)

		self._txtnum.text = amount
	else
		gohelper.setActive(self._gonum, false)
	end
end

function SurvivalRewardSelectTab:onClickBtnClick()
	if self.onClickTabCallBack then
		self.onClickTabCallBack(self.onClickTabContext, self)
	end
end

function SurvivalRewardSelectTab:setSelect(value)
	self.isSelect = value

	gohelper.setActive(self._goselect, self.isSelect)
end

return SurvivalRewardSelectTab
