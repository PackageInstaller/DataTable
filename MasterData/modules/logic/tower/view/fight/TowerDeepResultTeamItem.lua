-- chunkname: @modules/logic/tower/view/fight/TowerDeepResultTeamItem.lua

module("modules.logic.tower.view.fight.TowerDeepResultTeamItem", package.seeall)

local TowerDeepResultTeamItem = class("TowerDeepResultTeamItem", LuaCompBase)

function TowerDeepResultTeamItem:init(go)
	self.go = go
	self.goNormalContent = gohelper.findChild(self.go, "go_NormalContent")
	self.goNormalRoot = gohelper.findChild(self.go, "go_NormalContent/root")
	self.animNormalRoot = self.goNormalRoot:GetComponent(gohelper.Type_Animation)
	self.goHeroNormalContent = gohelper.findChild(self.go, "go_NormalContent/root/go_heroNormalContent")
	self.goHeroItem = gohelper.findChild(self.go, "go_NormalContent/root/go_heroNormalContent/go_heroitem")
	self.txtNormalDepth = gohelper.findChildText(self.go, "go_NormalContent/root/depth/txt_normalDepth")
	self.goFinalContent = gohelper.findChild(self.go, "go_FinalContent")
	self.goFinalRoot = gohelper.findChild(self.go, "go_FinalContent/root")
	self.animFinalRoot = self.goFinalRoot:GetComponent(gohelper.Type_Animation)
	self.goHeroFinalContent = gohelper.findChild(self.go, "go_FinalContent/root/go_heroFinalContent")
	self.goHeroGroupItem = gohelper.findChild(self.go, "go_FinalContent/root/go_heroFinalContent/group/go_herogroupitem")
	self.txtFinalDepth = gohelper.findChildText(self.go, "go_FinalContent/root/depth/txt_finalDepth")
	self.goNewRecord = gohelper.findChild(self.go, "go_FinalContent/root/depth/go_newRecord")
	self.groupItemPosList = {}

	for i = 1, 4 do
		self.groupItemPosList[i] = gohelper.findChild(self.go, "go_FinalContent/root/go_heroFinalContent/group/item" .. i)
	end

	self.finalHeroItemList = self:getUserDataTb_()
	self.normalHeroItemList = self:getUserDataTb_()

	gohelper.setActive(self.goHeroItem, false)
	gohelper.setActive(self.goHeroGroupItem, false)

	self.fightParam = FightModel.instance:getFightParam()
	self.heroEquipMoList = self.fightParam:getHeroEquipAndTrialMoList(true)
end

function TowerDeepResultTeamItem:refreshUI(index, curTeamDataList)
	self.teamData = curTeamDataList[index]

	gohelper.setActive(self.go, true)

	self.txtNormalDepth.text = string.format("%sM", self.teamData.deep)
	self.txtFinalDepth.text = string.format("%sM", self.teamData.deep)
	self.isFinalContent = index == #curTeamDataList

	gohelper.setActive(self.goNewRecord, self.isFinalContent and TowerPermanentDeepModel.instance.isNewRecord)
	gohelper.setActive(self.goNormalContent, not self.isFinalContent)
	gohelper.setActive(self.goFinalContent, self.isFinalContent)
	recthelper.setWidth(self.goNormalContent.transform, index % 2 == 0 and 0 or 80)

	if self.isFinalContent then
		self:createFinalHeroItem(self.finalHeroItemList)
	else
		self:createNormalHeroItem(self.normalHeroItemList)
	end

	gohelper.setActive(self.goNormalRoot, false)
	gohelper.setActive(self.goFinalRoot, false)
end

function TowerDeepResultTeamItem:createNormalHeroItem(heroItemList)
	local heroDataList = self.teamData.heroList

	for index = 1, 4 do
		local heroItem = heroItemList[index]

		if not heroItem then
			heroItem = {
				go = gohelper.clone(self.goHeroItem, self.goHeroNormalContent, "heroitem" .. index)
			}
			heroItem.simageRoleHead = gohelper.findChildSingleImage(heroItem.go, "simage_rolehead")
			heroItem.goEmpty = gohelper.findChild(heroItem.go, "go_empty")
			heroItemList[index] = heroItem
		end

		gohelper.setActive(heroItem.go, true)

		local heroData = heroDataList[index]

		gohelper.setActive(heroItem.goEmpty, not heroData)
		gohelper.setActive(heroItem.simageRoleHead.gameObject, heroData)

		if heroData then
			local skinId = 0

			if heroData.trialId and heroData.trialId > 0 then
				local trialConfig = lua_hero_trial.configDict[heroData.trialId][0]

				skinId = trialConfig.skin
			elseif heroData.heroId and heroData.heroId > 0 then
				local heroConfig = HeroConfig.instance:getHeroCO(heroData.heroId)

				skinId = heroConfig.skinId
			end

			local skinConfig = SkinConfig.instance:getSkinCo(skinId)

			heroItem.simageRoleHead:LoadImage(ResUrl.getHeadIconSmall(skinConfig.retangleIcon))
		end
	end
end

function TowerDeepResultTeamItem:createFinalHeroItem(heroItemList)
	for index = 1, 4 do
		local heroItem = heroItemList[index]

		if not heroItem then
			heroItem = {
				go = gohelper.clone(self.goHeroGroupItem, self.groupItemPosList[index], "heroitem" .. index)
			}
			heroItem.heroItemComp = MonoHelper.addNoUpdateLuaComOnceToGo(heroItem.go, TowerDeepResultHeroItem)
			heroItemList[index] = heroItem
		end

		local mo = self.heroEquipMoList[index]

		if mo then
			heroItem.heroItemComp:setData(mo.heroMo, mo.equipMo)
		else
			heroItem.heroItemComp:setData()
		end
	end
end

function TowerDeepResultTeamItem:showTeamItem(time)
	TaskDispatcher.runDelay(self.playShowAnim, self, time)
end

function TowerDeepResultTeamItem:playShowAnim()
	gohelper.setActive(self.goNormalRoot, not self.isFinalContent)
	gohelper.setActive(self.goFinalRoot, self.isFinalContent)

	if self.isFinalContent then
		self.animFinalRoot:Play()
	else
		self.animNormalRoot:Play()
	end
end

function TowerDeepResultTeamItem:onDestroy()
	for _, heroItem in pairs(self.normalHeroItemList) do
		heroItem.simageRoleHead:UnLoadImage()
	end

	TaskDispatcher.cancelTask(self.playShowAnim, self)
end

return TowerDeepResultTeamItem
