-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreamteamchapter/view/DreamTeamChapterAlchemyMMGameView.lua

module("logic.extensions.dreamteamchapter.view.DreamTeamChapterAlchemyMMGameView", package.seeall)

local DreamTeamChapterAlchemyMMGameView = class("DreamTeamChapterAlchemyMMGameView", ViewComponent)

DreamTeamChapterAlchemyMMGameView.MAT_BOWL_NUM = 4

function DreamTeamChapterAlchemyMMGameView:ctor()
	DreamTeamChapterAlchemyMMGameView.super.ctor(self)
end

function DreamTeamChapterAlchemyMMGameView:unbindEvents()
	DreamTeamChapterAlchemyMMGameView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnCook)
	GameUtil.rmClickHandler(self._btnBook)
	GameUtil.rmClickHandler(self._btnClear)
end

function DreamTeamChapterAlchemyMMGameView:bindEvents()
	DreamTeamChapterAlchemyMMGameView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnCook, self._onClickBtnCook, self)
	GameUtil.addClickHandler(self._btnBook, self._onClickBtnBook, self)
	GameUtil.addClickHandler(self._btnClear, self._onClickBtnClear, self)
end

function DreamTeamChapterAlchemyMMGameView:buildUI()
	DreamTeamChapterAlchemyMMGameView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnCook = self:getGo("btnCook")
	self._btnBook = self:getGo("btnBook")
	self._btnClear = self:getGo("btnClear")
	self._matBowlList = {}

	for i = 1, DreamTeamChapterAlchemyMMGameView.MAT_BOWL_NUM do
		local matBowlGo = self:getGo("matBowl" .. i)

		table.insert(self._matBowlList, matBowlGo)
	end

	self._tableview = self:getGo("mat/tableview")
	self._tablecell = self:getGo("mat/tablecell")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function DreamTeamChapterAlchemyMMGameView:onExit()
	DreamTeamChapterAlchemyMMGameView.super.onExit(self)
	self._scrollList:dispose()
end

function DreamTeamChapterAlchemyMMGameView:onEnter()
	DreamTeamChapterAlchemyMMGameView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_DreamTeamChapterSmeltRes, self._onSmeltRes, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 595001
	end

	self._actCfg = DreamTeamChapterConfig.instance:getActivityCfg(self._activityId)
	self._materialCfgs = DreamTeamChapterConfig.instance:getAlchemyMaterialCfgs(self._activityId)

	self._scrollList:reloadData(self._materialCfgs)

	self._selectMatNumMap = {}
	self._selectMatIdList = {}

	local key = "DreamTeamChapterAlchemyMMGameView_" .. self._activityId
	local isNotFirst = GameUtil.getUserData(key)

	if not isNotFirst then
		GameUtil.saveUserData(key, true)
		self:_onClickBtnTip()
	end

	self:_updateBowl()
end

function DreamTeamChapterAlchemyMMGameView:_onUpdate()
	self._info = DreamTeamChapterModel.instance:getInfo(self._activityId)

	self._scrollList:reloadData(self._materialCfgs)
	self:_updateBowl()
end

function DreamTeamChapterAlchemyMMGameView:_onSmeltRes(sucSmeltDrug)
	if sucSmeltDrug then
		self._selectMatNumMap = {}
		self._selectMatIdList = {}
	end

	self:_onUpdate()
end

function DreamTeamChapterAlchemyMMGameView:_updateBowl()
	for i = 1, DreamTeamChapterAlchemyMMGameView.MAT_BOWL_NUM do
		local matBowlGo = self._matBowlList[i]
		local imgMat = goutil.findChild(matBowlGo, "imgMat")
		local btnMat = goutil.findChild(matBowlGo, "btnMat")
		local txtNum = goutil.findChildTextComponent(matBowlGo, "txtNum")
		local matId = checknumber(self._selectMatIdList[i])
		local selectMatNum = checknumber(self._selectMatNumMap[matId])
		local matCfg = DreamTeamChapterConfig.instance:getAlchemyMaterialCfg(self._activityId, matId)

		if matCfg then
			if not matCfg.materialStr then
				local materialStr = ""
				local matType, materialId, matNum = MaterialMgr.getMatParams(materialStr)

				txtNum.text = selectMatNum

				if checknumber(matType) > 0 then
					MaterialMgr.setIcon(imgMat, matType, materialId, nil, nil)
				end

				GameUtil.SetActive(matBowlGo, checknumber(matId) > 0)
				GameUtil.addClickHandler(btnMat, function()
					TipsFacade.instance:openItemSourceView(materialStr)
				end, self)
			end
		end
	end
end

function DreamTeamChapterAlchemyMMGameView:_clearBowl()
	for i = 1, DreamTeamChapterAlchemyMMGameView.MAT_BOWL_NUM do
		local matBowlGo = self._matBowlList[i]
		local imgMat = goutil.findChild(matBowlGo, "imgMat")
		local btnMat = goutil.findChild(matBowlGo, "btnMat")

		MaterialMgr.clearIcon(imgMat)
		GameUtil.rmClickHandler(btnMat)
	end
end

function DreamTeamChapterAlchemyMMGameView:_updateCell(view, cell, data)
	local item = goutil.findChild(cell, "item")
	local btnAdd = goutil.findChild(cell, "btnAdd")
	local btnReduce = goutil.findChild(cell, "btnReduce")
	local select = goutil.findChild(cell, "select")
	local num = goutil.findChildTextComponent(cell, "num")
	local txtNum = goutil.findChildTextComponent(cell, "num/txtNum")
	local txtName = goutil.findChildTextComponent(cell, "name/txtName")
	local matName = MaterialMgr.getMaterialsNameByCfg(data.materialStr)

	txtNum.text = checknumber(self._selectMatNumMap[data.materialId])
	txtName.text = matName

	MaterialMgr.setCellByCfg(data.materialStr, item)
	GameUtil.SetActive(num, checknumber(self._selectMatNumMap[data.materialId]) > 0)
	GameUtil.addClickHandler(btnAdd, function()
		local hasSelect = table.indexof(self._selectMatIdList, data.materialId)

		if not hasSelect and #self._selectMatIdList >= DreamTeamChapterAlchemyMMGameView.MAT_BOWL_NUM then
			FloatWordMgr.instance:show(lang("可选材料种类已达上限"))

			return
		end

		self._selectMatNumMap[data.materialId] = checknumber(self._selectMatNumMap[data.materialId]) + 1

		if self._selectMatNumMap[data.materialId] == 1 then
			table.insert(self._selectMatIdList, data.materialId)
		end

		self:_onUpdate()
	end, self)
	GameUtil.addClickHandler(btnReduce, function()
		if checknumber(self._selectMatNumMap[data.materialId]) > 0 then
			self._selectMatNumMap[data.materialId] = checknumber(self._selectMatNumMap[data.materialId]) - 1

			if self._selectMatNumMap[data.materialId] <= 0 then
				local idx = table.indexof(self._selectMatIdList, data.materialId)

				if idx then
					table.remove(self._selectMatIdList, idx)
				end
			end

			self:_onUpdate()
		end
	end, self)
	GameUtil.SetActive(select, checknumber(self._selectMatNumMap[data.materialId]) > 0)
end

function DreamTeamChapterAlchemyMMGameView:_clearCell(cell)
	local item = goutil.findChild(cell, "item")
	local btnAdd = goutil.findChild(cell, "btnAdd")
	local btnReduce = goutil.findChild(cell, "btnReduce")

	MaterialMgr.resetAll(item)
	GameUtil.rmClickHandler(btnAdd)
	GameUtil.rmClickHandler(btnReduce)
end

function DreamTeamChapterAlchemyMMGameView:_onClickBtnClear()
	self._selectMatNumMap = {}
	self._selectMatIdList = {}

	self:_onUpdate()
end

function DreamTeamChapterAlchemyMMGameView:_onClickBtnBook()
	UIStateManager.instance:push(ViewName.DreamTeamChapterAlchemyMMBookView, self._activityId)
end

function DreamTeamChapterAlchemyMMGameView:_onClickBtnCook()
	if #self._selectMatIdList <= 0 then
		FloatWordMgr.instance:show(lang("请先选择材料再制作"))

		return
	end

	local finalMaterialList = self:_getFinalMaterialList()
	local hasSmeltPotionCurDrug = DreamTeamChapterController.instance:hasSmeltPotionCurDrug(self._activityId, finalMaterialList)

	if hasSmeltPotionCurDrug then
		FloatWordMgr.instance:show(lang("您已成功冶炼过这种药水，换换配方吧"))

		return
	end

	DreamTeamChapterController.instance:sendPM_DreamTeamChapterSmeltReq(self._activityId, finalMaterialList)
end

function DreamTeamChapterAlchemyMMGameView:_onClickBtnTip()
	local ruleCfg = DreamTeamChapterConfig.instance:getAlchemyRuleCfgs(self._actCfg.ruleIdAlchemyMM)
	local ruleList = {}

	for i, v in ipairs(ruleCfg) do
		local obj = {}

		obj.url = v.resPath
		obj.desc = v.desc

		table.insert(ruleList, obj)
	end

	TipsFacade.instance:openImageRuleView(ruleList, "游戏规则")
end

function DreamTeamChapterAlchemyMMGameView:_getFinalMaterialList()
	local list = {}

	for i, matId in ipairs(self._selectMatIdList) do
		local num = self._selectMatNumMap[matId]

		for i = 1, num do
			table.insert(list, matId)
		end
	end

	return list
end

return DreamTeamChapterAlchemyMMGameView
