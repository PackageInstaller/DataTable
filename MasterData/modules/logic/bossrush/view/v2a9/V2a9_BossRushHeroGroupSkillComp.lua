-- chunkname: @modules/logic/bossrush/view/v2a9/V2a9_BossRushHeroGroupSkillComp.lua

module("modules.logic.bossrush.view.v2a9.V2a9_BossRushHeroGroupSkillComp", package.seeall)

local V2a9_BossRushHeroGroupSkillComp = class("V2a9_BossRushHeroGroupSkillComp", LuaCompBase)

function V2a9_BossRushHeroGroupSkillComp:init(go)
	self.viewGO = go
	self.root = gohelper.findChild(self.viewGO, "fightassassinwheelview/Root")
	self._txtskillTitle = gohelper.findChildText(self.viewGO, "fightassassinwheelview/Root/Image_skillBG/#txt_skillTitle")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V2a9_BossRushHeroGroupSkillComp:addEventListeners()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onLoadingCloseView, self, LuaEventSystem.High)
end

function V2a9_BossRushHeroGroupSkillComp:removeEventListeners()
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onLoadingCloseView, self, LuaEventSystem.High)
end

function V2a9_BossRushHeroGroupSkillComp:_onReceiveAct128SpFirstHalfSelectItemReply()
	self:refreshView()
end

function V2a9_BossRushHeroGroupSkillComp:_onLoadingCloseView(viewName)
	if viewName == ViewName.V2a9_BossRushSkillBackpackView then
		if self._skillitems then
			local mos = V2a9BossRushModel.instance:getAllEquipMos(self._stage)

			for i = 1, BossRushEnum.V2a9FightEquipSkillMaxCount do
				if mos[i] then
					local itemType = mos[i]:getItemType()
					local skillitem = self:_getSkillItem(i)

					if mos[i] then
						if self._equidItemTypes[i] then
							if mos[i] ~= self._equidItemTypes[i] then
								skillitem:playAnim(BossRushEnum.S01Anim.Load)
							end
						else
							skillitem:playAnim(BossRushEnum.S01Anim.Load)
						end
					elseif self._equidItemTypes[i] then
						skillitem:playAnim(BossRushEnum.S01Anim.Unload)
					end
				end
			end
		end

		self:refreshView()
	end
end

function V2a9_BossRushHeroGroupSkillComp:_editableInitView()
	self._skillitemroot = gohelper.findChild(self.root, "simage_wheel")
	self._skillitemPrefab = gohelper.findChild(self.root, "simage_wheel/go_skillitem")

	gohelper.setActive(self._skillitemPrefab, false)

	self._skillitems = self:getUserDataTb_()
	self._txtskillTitle.text = luaLang("bossrush_skillcomp_title")
end

function V2a9_BossRushHeroGroupSkillComp:onUpdateMO()
	local episodeId = HeroGroupModel.instance.episodeId
	local co = BossRushConfig.instance:getEpisodeCoByEpisodeId(episodeId)

	self._stage = co.stage

	local actId = AssassinOutsideModel.instance:getAct195Id()

	AssassinOutSideRpc.instance:sendGetAssassinOutSideInfoRequest(actId, self._refreshModel, self)
end

function V2a9_BossRushHeroGroupSkillComp:_refreshModel()
	AssassinBackpackListModel.instance:setAssassinBackpackList()
	V2a9BossRushSkillBackpackListModel.instance:setMoList(self._stage)
	self:refreshView()
end

function V2a9_BossRushHeroGroupSkillComp:refreshView()
	self._equidItemTypes = {}

	local mos = V2a9BossRushModel.instance:getAllEquipMos(self._stage)
	local index = 1

	if mos then
		for _, mo in ipairs(mos) do
			local skillitem = self:_getSkillItem(index)

			skillitem:onUpdateMO(mo)

			index = index + 1
			self._equidItemTypes[mo:getIndex()] = mo:getItemType()
		end
	end

	if self._skillitems then
		for i = 1, #self._skillitems do
			gohelper.setActive(self._skillitems[i].viewGO, i < index)
		end
	end
end

function V2a9_BossRushHeroGroupSkillComp:_getSkillItem(index)
	local item = self._skillitems[index]

	if not item then
		local root = gohelper.findChild(self._skillitemroot, index .. "/go_item")
		local go = gohelper.clone(self._skillitemPrefab, root)

		item = self:getUserDataTb_()
		item = MonoHelper.addNoUpdateLuaComOnceToGo(go, V2a9_BossRushHeroGroupSkillCompItem)
		self._skillitems[index] = item
	end

	return item
end

return V2a9_BossRushHeroGroupSkillComp
