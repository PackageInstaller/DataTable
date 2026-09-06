-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mahjongbattle/model/MahjongBattleFmtMo.lua

module("logic.extensions.mahjongbattle.model.MahjongBattleFmtMo", package.seeall)

local MahjongBattleFmtMo = class("MahjongBattleFmtMo", BaseCustomFmtMo)

function MahjongBattleFmtMo:initParams(activityId)
	self._proxyPool = {}
	self.activityId = activityId
	self.topTitleStr = "麻将乱斗"
	self.isShowPetBag = false
	self.isOnlyUpdateExistPet = true
	self.ruleDescStr = ""
	self._curPetMoList = {}

	local isTeachMode = MahjongBattleController.instance:getIsTeachMode()

	if isTeachMode then
		local teachCfg = MahjongBattleConfig.instance:getTeachCfg(self.activityId)

		if teachCfg then
			if not teachCfg.teachCreepsIds then
				local teachCreepsIds = {}

				for _, petId in ipairs(teachCreepsIds) do
					local petMo = MahjongBattleModel.instance:getPetMo(self.activityId, petId, 0)

					if petMo then
						table.insert(self._curPetMoList, petMo)
					end
				end
			end
		end
	else
		local challengeInfo = MahjongBattleModel.instance:getCurChallengeInfoByActId(activityId)

		if challengeInfo then
			if not challengeInfo.creepsInfos then
				local creepsInfos = {}

				for _, info in ipairs(creepsInfos) do
					local petMo = MahjongBattleModel.instance:getPetMo(self.activityId, info.creepsId, info.awakenLevel)

					if petMo then
						table.insert(self._curPetMoList, petMo)
					end
				end
			end
		end
	end

	self:clearAllPetList()
	self:tryInitPetList()
end

function MahjongBattleFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		if MahjongBattleController.instance:getIsTeachMode() then
			MahjongBattleController.instance:startTeachFight(self.activityId, simpleForm)
		else
			MahjongBattleController.instance:startFight(self.activityId, simpleForm)
		end
	end

	self:setFightHandler(handler, nil)
end

function MahjongBattleFmtMo:initPetList()
	for _, petMo in ipairs(self._curPetMoList) do
		self:addPetToList(petMo)
	end
end

function MahjongBattleFmtMo:getMonsterConfigList()
	return {}
end

function MahjongBattleFmtMo:getFmtInfoConfig()
	return {}
end

function MahjongBattleFmtMo:getExtendViewName()
	return ViewName.MahjongBattleFmtExView
end

function MahjongBattleFmtMo:updateCellTop(cell, petMo)
	local luaCls = MahjongBattleTopCell
	local url = MahjongBattleTopCell.prefabUrl
	local proxy = MaterialMgr.getProxyWithOutPool(url, luaCls, cell)

	if proxy then
		self._proxyPool[cell] = proxy

		proxy.binder:checkAndShowIcon(self.activityId, petMo.awakeLevel)
	end
end

function MahjongBattleFmtMo:clearCellTop(cell)
	MahjongBattleFmtMo.super.clearCellTop(self, cell)

	local proxy = self._proxyPool[cell]

	if proxy then
		proxy.binder:onExit()
	end

	self._proxyPool[cell] = nil
end

return MahjongBattleFmtMo
