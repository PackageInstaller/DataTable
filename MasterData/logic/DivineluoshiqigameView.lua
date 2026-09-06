-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiunuobrotherhood/view/copy/DivineluoshiqigameView.lua

module("logic.extensions.xiunuobrotherhood.view.copy.DivineluoshiqigameView", package.seeall)

local DivineluoshiqigameView = class("DivineluoshiqigameView", XiuNuoBrotherhoodGameView)

function DivineluoshiqigameView:_refreshViewPos()
	self._isCanFight = false
	self._fightBossId = 0

	local countHave = 0
	local totalNum = 0
	local getNum = 0

	for i, v in ipairs(XiuNuoBrotherhoodModel.instance:getEnemyList(self._stageCfg.bossPlanId)) do
		if not string.nilorempty(self._bossPlan[v.bossId].prize) then
			local params = string.split(self._bossPlan[v.bossId].prize, "#")

			for j, k in ipairs(params) do
				local matType, id, matNum

				matType, id, matNum = MaterialMgr.getMatParams(k)

				if matType == self._activityItemType and id == self._activityItem then
					totalNum = totalNum + matNum

					if v.state == -1 then
						getNum = getNum + matNum
					end

					break
				end
			end
		end

		if v.state ~= -1 then
			if v.state == 1 then
				self._isCanFight = true
				self._fightBossId = v.bossId
			end
		else
			countHave = countHave + 1
		end

		if not self._enemyDataList[v.bossId] then
			self._enemyDataList[v.bossId] = {}
			self._enemyDataList[v.bossId].go = goutil.cloneAndSetParent(self._enemyCell, self._enemyContainer.transform)
		end

		self._enemyDataList[v.bossId].bossId = v.bossId
		self._enemyDataList[v.bossId].state = v.state
		self._enemyDataList[v.bossId].step = v.step
	end

	for i, v in pairs(self._enemyDataList) do
		self:_updateEnemyCell(v.go, v)
	end

	self._txtGet.text = langPara("当前获得材料:%d/%d\n当前波数:%d/%d", getNum, totalNum, countHave, #self._bossPlan)

	for i, v in ipairs(self._enemyPosList) do
		v.isEmpty = true
	end

	self._scrollList:reloadData(self._enemyPosList)

	if self._isCanFight == true then
		SxGameModel.instance:waitMoveRes()
	else
		settimer(0.2, self._canMove, self, false)
	end

	self._enemyContainer.transform:SetAsLastSibling()
end

return DivineluoshiqigameView
