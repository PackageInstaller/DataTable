-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineweileitaclg/view/DivineWeiLeiTaClgScoreView.lua

module("logic.extensions.divineweileitaclg.view.DivineWeiLeiTaClgScoreView", package.seeall)

local DivineWeiLeiTaClgScoreView = class("DivineWeiLeiTaClgScoreView", ViewComponent)

function DivineWeiLeiTaClgScoreView:ctor()
	DivineWeiLeiTaClgScoreView.super.ctor(self)
end

function DivineWeiLeiTaClgScoreView:unbindEvents()
	DivineWeiLeiTaClgScoreView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function DivineWeiLeiTaClgScoreView:bindEvents()
	DivineWeiLeiTaClgScoreView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function DivineWeiLeiTaClgScoreView:buildUI()
	DivineWeiLeiTaClgScoreView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._tableView = self:getGo("tableView")
	self._tableCell = self:getGo("tableCell")
	self._tableList = ScrollerList.create(self._tableView, self._tableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function DivineWeiLeiTaClgScoreView:onExit()
	DivineWeiLeiTaClgScoreView.super.onExit(self)
	self._tableList:dispose()
end

function DivineWeiLeiTaClgScoreView:onEnter()
	DivineWeiLeiTaClgScoreView.super.onEnter(self)

	self._activityId = self:getFirstParam()

	local damageCfgs = DivineWeiLeiTaClgConfig.instance:getNormalDnamgeCfg(self._activityId)
	local resultList = {}
	local totalScore = 0

	for i, v in ipairs(damageCfgs) do
		totalScore = totalScore + v.score

		local nextDamageCfg = damageCfgs[i + 1]

		if nextDamageCfg then
			table.insert(resultList, {
				index = i,
				damageCfg = v,
				damageUp = nextDamageCfg.damage,
				totalScore = totalScore
			})
		else
			table.insert(resultList, {
				index = i,
				damageCfg = v,
				totalScore = totalScore
			})
		end
	end

	self._tableList:reloadData(resultList)
end

function DivineWeiLeiTaClgScoreView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtIndex = goutil.findChildTextComponent(go, "txtIndex")
	local txtDamage = goutil.findChildTextComponent(go, "txtDamage")
	local txtScore = goutil.findChildTextComponent(go, "txtScore")

	txtScore.text = langPara("%d积分", data.totalScore)
	txtIndex.text = data.index

	local descDown = data.damageCfg.damage

	if descDown >= 10000 then
		descDown = langPara("%d万", checkint(descDown / 10000))
	end

	if data.damageUp then
		local descUp = data.damageUp

		if descUp >= 10000 then
			descUp = langPara("%d万", checkint(descUp / 10000))
		end

		txtDamage.text = langPara("%s-%s", descDown, descUp)
	else
		txtDamage.text = langPara("%s以上", descDown)
	end
end

function DivineWeiLeiTaClgScoreView:_clearCell(cell)
	return
end

return DivineWeiLeiTaClgScoreView
