-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xinxiyamirror/view/formation/XXYMissionFmtView.lua

module("logic.extensions.xinxiyamirror.view.formation.XXYMissionFmtView", package.seeall)

local XXYMissionFmtView = class("XXYMissionFmtView", MissionFmtView)

function XXYMissionFmtView:_getMonsterCo()
	local params = self._viewPresentor:getFirstParam()

	if params then
		return XinxiyaMirrorConfig.instance:getMasterTeamCfg(params.masterId)
	end

	return nil
end

function XXYMissionFmtView:_getCreepCos()
	local params = self._viewPresentor:getFirstParam()

	if params then
		return XinxiyaMirrorConfig.instance:getMasterCreepsCfg(params.masterId)
	end

	return nil
end

function XXYMissionFmtView:_refreshFromation()
	self:_innerrefreshFromation()
end

function XXYMissionFmtView:_innerrefreshFromation()
	local params = self._viewPresentor:getFirstParam()

	if params and params.isMirror then
		self:_rewriteInitFormation()

		return
	end

	XXYMissionFmtView.super._innerrefreshFromation(self)
end

function XXYMissionFmtView:_rewriteInitFormation()
	local data = XinxiyaMirrorModel.instance:getBattleMirrorFormation()

	if data == nil or data.petSimpleView == nil or data.curForm == nil then
		XXYMissionFmtView.super._innerrefreshFromation(self)

		return
	end

	local posList = {}

	for num, id in pairs(data.curForm.pos) do
		if checknumber(num) > 0 and checknumber(id) > 0 then
			posList[checknumber(id)] = checknumber(num)
		end
	end

	local teams = {}
	local formations = {}

	for _, info in pairs(data.petSimpleView) do
		if info and checknumber(info.petId) > 0 then
			local fppMo = FightingPowerPetMo.New()
			local pos = posList[info.petId]

			fppMo:fromXinxiyaCreepCo(info, pos)

			local petMo = BagPetsController.instance:getPet(info.petId)

			if petMo then
				fppMo.creepName = petMo.name or lang("prize_xiulian_pet")
			end

			table.insert(teams, fppMo)

			formations[pos] = fppMo
		end
	end

	ArraySort.sortOn(teams, "position")
	self:initFormation(formations, teams, (data.curForm.extParams or nil) and checknumber(data.curForm.extParams.heroSkillId))
end

function XXYMissionFmtView:_setRightSpeedAndPower(speed, power)
	XXYMissionFmtView.super._setRightSpeedAndPower(self, speed, power)

	self._speed.text = "？？？"
	self._powerTxt.text = "？？？"
end

function XXYMissionFmtView:_onClickPower()
	FloatWordMgr.instance:show("全员战斗力：？？？")
end

function XXYMissionFmtView:_onClickSpeed()
	FloatWordMgr.instance:show("全员速度：？？？")
end

function XXYMissionFmtView:_selectItem(index)
	if self._infoSeats[index] then
		local param = clone(self._infoSeats[index])

		param.hideZdl = true

		CommonTipsMgr.instance:showPetTips(param)
	end
end

return XXYMissionFmtView
