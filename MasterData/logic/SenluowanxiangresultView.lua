-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/tianmanking/SenluowanxiangresultView.lua

module("logic.extensions.timelimitedchallenge.view.tianmanking.SenluowanxiangresultView", package.seeall)

local SenluowanxiangresultView = class("SenluowanxiangresultView", AnheimmresultView)

function SenluowanxiangresultView:onEnter()
	local isWin = self:_isAllEnemiesDeath()
	local isPerfect = TianmanKingModel.instance:getIsWin()

	goutil.setActive(self._btnOk.gameObject, isPerfect)
	goutil.setActive(self._btnCancel.gameObject, not isPerfect)
	goutil.setActive(self._failure, not isPerfect)
	goutil.setActive(self._rewards, isPerfect)
	goutil.setActive(self._btnReGame.gameObject, false)
	goutil.setActive(self._winTrue, isWin)
	goutil.setActive(self._winFalse, not isWin)
	goutil.setActive(self._perfectTrue, isPerfect)
	goutil.setActive(self._perfectFalse, not isPerfect)

	self._txtWin.text = TianmanKingController.instance:getText("TEXT_32")
	self._txtPerfect.text = TianmanKingController.instance:getText("TEXT_33")
	self._txtTips.text = ""
	self._cells = {}

	if isPerfect then
		self._txtTitle.text = TianmanKingController.instance:getText("TEXT_34")

		local items = {}
		local challengeType, challengeId = TianmanKingModel.instance:getBattleChallengeTypeAndId()
		local stageCo = TianmanKingConfig.instance:getStageByTypeAndStage(challengeType, challengeId)

		for _, v in ipairs(string.split(stageCo.prize, "#")) do
			local data = {}

			data.type, data.id, data.num = MaterialMgr.getMatParams(v)

			table.insert(items, data)
		end

		self:_updateRewards(items)
	else
		self._txtTitle.text = TianmanKingController.instance:getText("TEXT_35")
	end
end

function SenluowanxiangresultView:_isAllEnemiesDeath()
	local count = 0
	local enemys = BattleModel.instance:getEnemyUnits()

	for k, v in pairs(enemys) do
		if v.attrs:getCurHp() <= 0 then
			count = count + 1
		end
	end

	return count == #enemys
end

function SenluowanxiangresultView:_onClickOk()
	self:_closeResultView()
end

function SenluowanxiangresultView:_onClickCancel()
	self:_closeResultView()
end

return SenluowanxiangresultView
