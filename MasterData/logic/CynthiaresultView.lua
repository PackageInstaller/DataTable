-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/cynthia/CynthiaresultView.lua

module("logic.extensions.timelimitedchallenge.view.cynthia.CynthiaresultView", package.seeall)

local CynthiaresultView = class("CynthiaresultView", ViewComponent)

function CynthiaresultView:unbindEvents()
	CynthiaresultView.super.unbindEvents(self)
	self._btnOk:RemoveClickListener()
end

function CynthiaresultView:bindEvents()
	CynthiaresultView.super.bindEvents(self)
	self._btnOk:AddClickListener(self._onClickClose, self)
end

function CynthiaresultView:onExit()
	CynthiaresultView.super.onExit(self)

	self._mo.isWin = false
end

function CynthiaresultView:buildUI()
	CynthiaresultView.super.buildUI(self)

	self._btnOk = self:getBtn("btnOk")
	self._txtTip = self:getTxt("content/top/txtTip")
	self._down = self:getGo("content/dowm")
	self._itemsGroup = self:getGo("content/dowm/rewards/itemsGroup")
	self._txtTitle = self:getTxt("txtTitle")
	self._txt = MaterialMgr.findGraphicText(self.mainGO, "content/dowm/rewards/item")
end

function CynthiaresultView:onEnter()
	CynthiaresultView.super.onEnter(self)

	self._challengeId = checknumber(self:getFirstParam())

	local params = {
		[17] = {
			petName = "辛西娅",
			mainview = ViewName.CynthiamainView,
			challengeview = ViewName.Cynthiachallengeview
		},
		[177] = {
			petName = "奇迹修尔",
			mainview = ViewName.MiracleXiuerMainView,
			challengeview = ViewName.MiracleXiuerChallengeView
		}
	}

	self._param = params[self._challengeId]
	self._mo = CynthiaModel.instance:getActMo(self._challengeId)

	self:refreshUI()

	if self._mo.isAllPass then
		UIJumper.instance:pushOneStack(self._param.mainview, true, self._challengeId)
	else
		UIJumper.instance:pushOneStack(self._param.challengeview, true, self._challengeId)
	end
end

function CynthiaresultView:refreshUI()
	local passLimit = checkint(CynthiaConfig.instance:getCommonValue(self._challengeId, "passMinAlive"))

	if self._mo.isWin then
		if passLimit > self._mo.alivePets then
			self._txtTitle.text = lang("战斗失败")
			self._txtTip.text = langPara("成功击败敌阵全部精灵！\n但未存活%s只或以上精灵！", passLimit)
		else
			self._txtTitle.text = lang("战斗胜利")
			self._txtTip.text = self._mo.isAllPass and langPara("恭喜你成功通关%s挑战！", self._param.petName) or langPara("击败敌阵全部精灵，破阵成功！\n精灵存活=%s只", self._mo.alivePets)
		end
	else
		self._txtTitle.text = lang("战斗失败")
		self._txtTip.text = lang("未能击败敌阵全部精灵！")
	end

	local ciMatStr = ""
	local items = MaterialController.instance:saveChangeSetToTemp(self._mo.ciList)

	if items ~= nil and #items > 0 then
		local tem = {}

		for i, v in ipairs(items) do
			local type, id, num = v:getMatType(), v:getId(), v:GetCount()
			local matStr = MaterialMgr.createSerName(type, id, num)
			local c = MaterialMgr.getContentMatStr(matStr, 100, -10, MaterialMgr.ICON_TYPE_MATID)

			table.insert(tem, c)
		end

		ciMatStr = table.concat(tem, " ")
	end

	if GameUtil.isEmptyString(ciMatStr) then
		GameUtil.SetActive(self._down, false)
	else
		GameUtil.SetActive(self._down, true)

		self._txt.text = ciMatStr
	end
end

function CynthiaresultView:_onClickClose()
	self:close()
	BattleController.instance:endBattle()

	if self._mo.isAllPass then
		CynthiaModel.instance:showCI(self._challengeId)
	end
end

return CynthiaresultView
