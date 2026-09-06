-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/farnas/view/FarnasnordetailView.lua

module("logic.extensions.farnas.view.FarnasnordetailView", package.seeall)

local FarnasnordetailView = class("FarnasnordetailView", ViewComponent)

function FarnasnordetailView:buildUI()
	FarnasnordetailView.super.buildUI(self)

	self._cellParent = goutil.findChild(self.mainGO, "detailCol/content")
	self._detailScrollercell = goutil.findChild(self.mainGO, "detailCol/detailScrollercell")
	self._btnSure = goutil.findChild(self.mainGO, "btnSure")
	self._txtScore = self:getTxt("txtScore")
	self._txtScoreTitle = self:getTxt("txtScoreTitle")
	self._singleLine = self:getGo("detailCol/content"):GetComponent(ComponentType.UILayoutSingleLine)
end

function FarnasnordetailView:bindEvents()
	FarnasnordetailView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function FarnasnordetailView:unbindEvents()
	FarnasnordetailView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function FarnasnordetailView:onEnter()
	FarnasnordetailView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._groupId = checknumber(params[2])
	self._dataBitId = checknumber(params[3])
	self._sureCallBack = params[4]

	self.addGEvent(self, GlobalNotify.FarnasClgNotifyExtremeFightResultRes, self._onUpdate, self)
	self:_onUpdate()
end

function FarnasnordetailView:onExit()
	FarnasnordetailView.super.onExit(self)
end

function FarnasnordetailView:_onUpdate()
	self._infoList = self._sureCallBack and FarnasController.instance:getCacheNorInfoList() or FarnasController.instance:getDetailInfoListOfNorClg(self._activityId, self._groupId, self._dataBitId)

	local cfgs = FarnasConfig.instance:getNorRuleCfgs(self._activityId)

	for i, v in ipairs(cfgs) do
		local go = goutil.findChild(self._cellParent, "cell" .. i)

		go = go or goutil.cloneAndSetParent(self._detailScrollercell, self._cellParent.transform, "cell" .. i)

		goutil.setActive(go, true)
		self:_updateDetailCell(go, v)
	end

	local score = checknumber(self._infoList.normalClgWinBaseScore)
	local name = "cell" .. #cfgs + 1
	local go = goutil.findChild(self._cellParent, name)

	go = go or goutil.cloneAndSetParent(self._detailScrollercell, self._cellParent.transform, name)

	goutil.setActive(go, true)
	self:_updateScoreDetailCell(go, score)
	self._singleLine:Layout()

	self._txtScore.text = self:_getTotalScroe()
	self._txtScoreTitle.text = self._sureCallBack and "本次挑战总分" or "本日最高积分"
end

function FarnasnordetailView:_updateDetailCell(cell, data)
	local ruleId = data.ruleId
	local info = self:_getInfo(ruleId)
	local name = data.name

	if info then
		if not info.counter then
			local cond = 0

			if info then
				if not info.score then
					local score = 0
					local mainGo = cell.gameObject
					local txtName = goutil.findChildTextComponent(mainGo, "txtName")
					local txtCond = goutil.findChildTextComponent(mainGo, "txtCond")
					local txtSouilCount = goutil.findChildTextComponent(mainGo, "txtSouilCount")

					txtName.text = name
					txtCond.text = string.format("%s次", cond)

					local color = ""

					if score > 0 then
						color = GameEnum.ColorConst.Green
					elseif score <= 0 then
						color = GameEnum.ColorConst.Red
					end

					txtSouilCount.text = string.format("<color=%s>%s</color>", color, score)
				end
			end
		end
	end
end

function FarnasnordetailView:_updateScoreDetailCell(cell, score)
	local mainGo = cell.gameObject
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtCond = goutil.findChildTextComponent(mainGo, "txtCond")
	local txtSouilCount = goutil.findChildTextComponent(mainGo, "txtSouilCount")
	local cond = score > 0 and 1 or 0

	txtName.text = "破阵"
	txtCond.text = string.format("%s次", cond)

	local color = ""

	if score > 0 then
		color = GameEnum.ColorConst.Green
	elseif score <= 0 then
		color = GameEnum.ColorConst.Red
	end

	txtSouilCount.text = string.format("<color=%s>%s</color>", color, score)
end

function FarnasnordetailView:_getInfo(ruleId)
	local info

	if self._infoList and self._infoList.ruleResult then
		for i, v in ipairs(self._infoList.ruleResult) do
			if v.ruleId == ruleId then
				info = v

				break
			end
		end
	end

	return info
end

function FarnasnordetailView:_onClickBtnSure()
	self:close()
	GameUtil.callBack(self._sureCallBack)
end

function FarnasnordetailView:_getTotalScroe()
	if self._infoList then
		return self._infoList.totalScore or 0
	end

	return 0
end

return FarnasnordetailView
