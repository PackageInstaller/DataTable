-- chunkname: @modules/logic/survival/view/map/SurvivalMapTalentView.lua

module("modules.logic.survival.view.map.SurvivalMapTalentView", package.seeall)

local SurvivalMapTalentView = class("SurvivalMapTalentView", BaseView)

function SurvivalMapTalentView:ctor(rootPath)
	self._rootPath = rootPath or ""
end

function SurvivalMapTalentView:onInitView()
	self._btnTalent = gohelper.findChildButtonWithAudio(self.viewGO, self._rootPath .. "Left/#btn_effect")
	self._goTalentTips = gohelper.findChild(self.viewGO, self._rootPath .. "Left/#go_effectTips")
	self._goTalentTipsItem = gohelper.findChild(self.viewGO, self._rootPath .. "Left/#go_effectTips/#scroll_tips/viewport/content/#go_effectItem")
end

function SurvivalMapTalentView:addEvents()
	self.addClickCb(self, self._btnTalent, self._onClickTalent, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnTalentChange, self._ontalentChange, self)
	self.viewContainer:registerCallback(SurvivalEvent.OnClickSurvivalScene, self._onSceneClick, self)
	self.viewContainer:registerCallback(SurvivalEvent.OnClickShelterScene, self._onSceneClick, self)
end

function SurvivalMapTalentView:removeEvents()
	self:removeClickCb(self._btnTalent)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnTalentChange, self._ontalentChange, self)
	self.viewContainer:unregisterCallback(SurvivalEvent.OnClickSurvivalScene, self._onSceneClick, self)
	self.viewContainer:unregisterCallback(SurvivalEvent.OnClickShelterScene, self._onSceneClick, self)
end

function SurvivalMapTalentView:onOpen()
	gohelper.setActive(self._goTalentTips, false)
	self:_ontalentChange()
end

function SurvivalMapTalentView:_onSceneClick()
	gohelper.setActive(self._goTalentTips, false)
end

function SurvivalMapTalentView:_onClickTalent()
	SurvivalStatHelper.instance:statBtnClick("_onClickTalent", "  SurvivalMapTalentView")

	local isActive = not self._goTalentTips.activeSelf

	gohelper.setActive(self._goTalentTips, isActive)

	if not isActive then
		return
	end

	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local datas = {}

	for i, v in ipairs(weekInfo.talents) do
		local talentCo = lua_survival_talent.configDict[v]

		if not talentCo then
			logError("天赋配置不存在：" .. tostring(v))
		else
			table.insert(datas, {
				title = talentCo.name,
				desc = talentCo.desc1
			})
		end
	end

	gohelper.CreateObjList(self, self._createDesc, datas, nil, self._goTalentTipsItem, nil, nil, nil, 1)
end

function SurvivalMapTalentView:_createDesc(obj, data, index)
	local title = gohelper.findChildTextMesh(obj, "#txt_title")
	local dec = gohelper.findChildTextMesh(obj, "#txt_dec")

	title.text = data.title
	dec.text = data.desc
end

function SurvivalMapTalentView:_ontalentChange()
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

	gohelper.setActive(self._btnTalent, #weekInfo.talents > 0)
end

return SurvivalMapTalentView
