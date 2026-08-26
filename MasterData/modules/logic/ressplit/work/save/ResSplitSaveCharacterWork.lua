-- chunkname: @modules/logic/ressplit/work/save/ResSplitSaveCharacterWork.lua

module("modules.logic.ressplit.work.save.ResSplitSaveCharacterWork", package.seeall)

local ResSplitSaveCharacterWork = class("ResSplitSaveCharacterWork", BaseWork)

function ResSplitSaveCharacterWork:onStart(context)
	local skinList = SkinConfig.instance:getAllSkinCoList()
	local monsterSkinList = lua_monster_skin.configList
	local allSkin = {}

	for i, v in pairs(skinList) do
		table.insert(allSkin, v)
	end

	for i, v in pairs(monsterSkinList) do
		table.insert(allSkin, v)
	end

	for i, v in pairs(allSkin) do
		if ResSplitModel.instance:isExcludeCharacter(v.characterId) and ResSplitModel.instance:isExcludeSkin(v.id) then
			-- block empty
		else
			self:_addSkinRes(v, false)
		end
	end

	local allHero = HeroConfig.instance.heroConfig.configDict

	for heroId, v in pairs(allHero) do
		local isExclude = ResSplitModel.instance:isExcludeCharacter(heroId)

		if isExclude == false then
			local skillArr = FightHelper.buildSkills(heroId)

			for i, m in ipairs(skillArr) do
				ResSplitModel.instance:addIncludeSkill(m)
			end

			local voicesCo = CharacterDataConfig.instance:getCharacterVoicesCo(heroId)

			if voicesCo then
				for audioId, co in pairs(voicesCo) do
					local audioInfo = ResSplitModel.instance.audioDic[audioId]

					if audioInfo then
						ResSplitModel.instance:setInclude(ResSplitEnum.AudioBank, audioInfo.bankName, true)
					end
				end
			end

			local path = ResUrl.getSignature(v.signature)

			ResSplitModel.instance:setInclude(ResSplitEnum.Path, path, isExclude)
		end
	end

	self:onDone(true)
end

function ResSplitSaveCharacterWork:_addSkinRes(config, exclude)
	local mainKey = string.format("skin:%d", config.id)
	local path = ResUrl.getHeadSkinSmall(config.id)

	ResSplitModel.instance:setInclude(ResSplitEnum.Path, path, exclude)

	local path = ResUrl.getHandbookheroIcon(config.id)

	ResSplitModel.instance:setInclude(ResSplitEnum.Path, path, exclude)

	local path = ResUrl.getHeadIconImg(config.drawing)

	ResSplitModel.instance:setInclude(ResSplitEnum.Path, path, exclude)
	ResSplitHelper.checkConfigEmpty(mainKey, "headIcon", config.headIcon)

	path = ResUrl.getHeadIconSmall(config.headIcon)

	ResSplitModel.instance:setInclude(ResSplitEnum.Path, path, false)

	path = ResUrl.getHeadIconMiddle(config.retangleIcon)

	ResSplitModel.instance:setInclude(ResSplitEnum.Path, path, exclude)

	path = ResUrl.getHeadIconSmall(config.retangleIcon)

	ResSplitModel.instance:setInclude(ResSplitEnum.Path, path, false)

	path = ResUrl.getHeadIconLarge(config.retangleIcon)

	ResSplitModel.instance:setInclude(ResSplitEnum.Path, path, exclude)

	path = ResUrl.getHeadIconLarge(config.largeIcon)

	ResSplitModel.instance:setInclude(ResSplitEnum.Path, path, exclude)

	path = ResUrl.getHeadSkinIconMiddle(config.skinGetIcon)

	ResSplitModel.instance:setInclude(ResSplitEnum.Path, path, exclude)

	path = ResUrl.getHeadSkinIconLarge(config.skinGetBackIcon)

	ResSplitModel.instance:setInclude(ResSplitEnum.Path, path, exclude)

	path = ResUrl.getLightLive2dFolder(config.live2d)

	ResSplitModel.instance:setInclude(ResSplitEnum.Folder, path, exclude)

	local live2dbg = config.live2dbg

	if not string.nilorempty(live2dbg) then
		path = ResUrl.getCharacterSkinLive2dBg(live2dbg)

		ResSplitModel.instance:setInclude(ResSplitEnum.Path, path, exclude)
	end

	path = ResUrl.getRolesPrefabStoryFolder(config.verticalDrawing)
	path = string.sub(path, 1, string.len(path) - 1)

	ResSplitModel.instance:setInclude(ResSplitEnum.Path, path, exclude)

	local arr = string.split(config.spine, "/")

	path = string.format("roles/%s/", arr[1])

	ResSplitModel.instance:setInclude(ResSplitEnum.Folder, path, exclude)

	arr = string.split(config.alternateSpine, "/")
	path = string.format("roles/%s/", arr[1])

	ResSplitModel.instance:setInclude(ResSplitEnum.Folder, path, exclude)

	local limitedCO = lua_character_limited.configDict[config.id]

	if limitedCO then
		if not string.nilorempty(limitedCO.entranceMv) then
			ResSplitModel.instance:setInclude(ResSplitEnum.Video, limitedCO.entranceMv, true)
		end

		if not string.nilorempty(limitedCO.spine) then
			path = ResUrl.getRolesBustPrefab(limitedCO.spine)

			ResSplitModel.instance:setInclude(ResSplitEnum.Path, path, exclude)
		end
	end

	local headSkinIconUnique = ResUrl.getHeadSkinIconUnique(config.id)

	if not string.nilorempty(headSkinIconUnique) then
		ResSplitModel.instance:setInclude(ResSplitEnum.Path, headSkinIconUnique, exclude)
	end

	local data = {}
	local spineParam = string.split(config.skin2dParams, "#")

	data.spinePath = spineParam[1]
	data.spinePos = spineParam[2] and string.splitToNumber(spineParam[2], ",") or {
		0,
		0
	}
	data.spineScale = spineParam[3] and tonumber(spineParam[3]) or 1

	if not string.nilorempty(data.spinePath) then
		ResSplitModel.instance:setInclude(ResSplitEnum.Path, string.gsub(data.spinePath, "\\", "/"), exclude)
	end

	if exclude == false then
		FightConfig.instance:_checkskinSkill()

		local skinSkillTLDict = FightConfig.instance._skinSkillTLDict[config.id]

		if skinSkillTLDict then
			for i, timeline in pairs(skinSkillTLDict) do
				ResSplitModel.instance:addIncludeTimeline(timeline)
			end
		end
	end
end

return ResSplitSaveCharacterWork
