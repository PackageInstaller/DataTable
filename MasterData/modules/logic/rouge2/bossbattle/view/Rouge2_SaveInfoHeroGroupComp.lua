-- chunkname: @modules/logic/rouge2/bossbattle/view/Rouge2_SaveInfoHeroGroupComp.lua

module("modules.logic.rouge2.bossbattle.view.Rouge2_SaveInfoHeroGroupComp", package.seeall)

local Rouge2_SaveInfoHeroGroupComp = class("Rouge2_SaveInfoHeroGroupComp", LuaCompBase)

function Rouge2_SaveInfoHeroGroupComp.Get(go)
	return MonoHelper.addNoUpdateLuaComOnceToGo(go, Rouge2_SaveInfoHeroGroupComp)
end

function Rouge2_SaveInfoHeroGroupComp:init(go)
	self.go = go
	self._loader = PrefabInstantiate.Create(self.go)

	self._loader:startLoad(Rouge2_Enum.ResPath.SaveInfoHeroGroupComp, self._onLoadDone, self)
end

function Rouge2_SaveInfoHeroGroupComp:_onLoadDone(loader)
	self:initGroupItem(loader:getInstGO())

	self._isInitDone = true

	self:refreshUI()
end

function Rouge2_SaveInfoHeroGroupComp:onDestroy()
	if self._isInitDone then
		self:onDestroyHeroGroup()
	end

	self._isInitDone = false
end

function Rouge2_SaveInfoHeroGroupComp:initGroupItem(goItem)
	self._goHeroGroup = goItem
	self._goRoot = gohelper.findChild(self._goHeroGroup, "#go_Root")
	self._goHeroList = gohelper.findChild(self._goHeroGroup, "#go_Root/#go_HeroList")
	self._goHeroIcon = gohelper.findChild(self._goHeroGroup, "#go_Root/#go_HeroList/#go_HeroIcon")
	self._goSystem = gohelper.findChild(self._goHeroGroup, "#go_Root/#go_System")
	self._imageSystemBg = gohelper.findChildImage(self._goHeroGroup, "#go_Root/#go_System/#image_SystemBg")
	self._txtSystem = gohelper.findChildText(self._goHeroGroup, "#go_Root/#go_System/#txt_System")
	self._simageSystem = gohelper.findChildSingleImage(self._goHeroGroup, "#go_Root/#go_System/#image_System")
	self._heroItemTab = self:getUserDataTb_()
end

function Rouge2_SaveInfoHeroGroupComp:onUpdateMO(lastTeamInfoList, systemId)
	self._lastTeamInfoList = lastTeamInfoList or {}
	self._systemId = systemId
	self._hasData = true

	self:refreshUI()
end

function Rouge2_SaveInfoHeroGroupComp:refreshUI()
	if not self._isInitDone or not self._hasData then
		return
	end

	self:refreshHeroGroupFlag()
	gohelper.CreateNumObjList(self._goHeroList, self._goHeroIcon, Rouge2_OutsideEnum.BossShowHeroCount, self._refreshHeroIconItem, self)
end

function Rouge2_SaveInfoHeroGroupComp:_refreshHeroIconItem(goHeroIcon, index)
	local heroItem = self._heroItemTab[index]

	if not heroItem then
		heroItem = self:getUserDataTb_()
		heroItem.goHas = gohelper.findChild(goHeroIcon, "go_Has")
		heroItem.simageHeroIcon = gohelper.findChildSingleImage(goHeroIcon, "go_Has/simage_HeroIcon")
		heroItem.goEmpty = gohelper.findChild(goHeroIcon, "go_Empty")
		self._heroItemTab[index] = heroItem
	end

	local teamInfo = self._lastTeamInfoList[index]
	local heroId = teamInfo and teamInfo:getHeroId()
	local hasHero = heroId and heroId ~= 0

	gohelper.setActive(heroItem.goHas, hasHero)
	gohelper.setActive(heroItem.goEmpty, not hasHero)

	if not hasHero then
		return
	end

	local skinCfg
	local isTrial = teamInfo and teamInfo:isTrial()

	if isTrial then
		local trialCo = teamInfo and teamInfo:getTrialCo()
		local skinId = trialCo and trialCo.skin

		skinCfg = SkinConfig.instance:getSkinCo(skinId)
	else
		skinCfg = HeroModel.instance:getCurrentSkinConfig(heroId)
	end

	local heroIcon = skinCfg and skinCfg.headIcon

	heroItem.simageHeroIcon:LoadImage(ResUrl.getHeadIconSmall(heroIcon))
end

function Rouge2_SaveInfoHeroGroupComp:refreshHeroGroupFlag()
	if self._systemId then
		local showSystemFlag = self._systemId ~= 0

		gohelper.setActive(self._goSystem, showSystemFlag)

		if not showSystemFlag then
			return
		end

		local tagCo = Rouge2_CareerConfig.instance:getBattleTagConfigBySystemId(self._systemId)

		if tagCo then
			if not tagCo.tagName then
				local tagName = ""

				self._txtSystem.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("rouge2_saveinfoherogroupcomp"), tagName)

				Rouge2_IconHelper.setTeamSystemIcon(self._systemId, self._simageSystem, self._imageSystemBg, Rouge2_Enum.SystemIconType.White)
			end
		end
	end
end

function Rouge2_SaveInfoHeroGroupComp:releaseAllHeroItem()
	if self._heroItemTab then
		for _, heroItem in pairs(self._heroItemTab) do
			heroItem.simageHeroIcon:UnLoadImage()
		end
	end
end

function Rouge2_SaveInfoHeroGroupComp:onDestroyHeroGroup()
	self._simageSystem:UnLoadImage()
	self:releaseAllHeroItem()
end

return Rouge2_SaveInfoHeroGroupComp
