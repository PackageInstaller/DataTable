-- chunkname: @modules/logic/ressplit/work/save/ResSplitSaveSkillWork.lua

module("modules.logic.ressplit.work.save.ResSplitSaveSkillWork", package.seeall)

local ResSplitSaveSkillWork = class("ResSplitSaveSkillWork", BaseWork)
local TimelineEffectType = {
	"FightTLEventTargetEffect",
	nil,
	nil,
	nil,
	"FightTLEventAtkEffect",
	"FightTLEventAtkFlyEffect",
	"FightTLEventAtkFullEffect",
	"FightTLEventDefEffect",
	[28] = "FightTLEventDefEffect"
}

function ResSplitSaveSkillWork:onStart(context)
	self.includeTimeLineDic = {}

	local includeSkillDic = ResSplitModel.instance:getIncludeSkill()

	for skillId, v in pairs(includeSkillDic) do
		local skillCO = lua_skill.configDict[skillId]

		if skillCO then
			self.includeTimeLineDic[ResUrl.getSkillTimeline(skillCO.timeline)] = true
		end
	end

	local dic = ResSplitModel.instance:getIncludeTimelineDic()

	for timeline, _ in pairs(dic) do
		self.includeTimeLineDic[ResUrl.getSkillTimeline(timeline)] = true
	end

	local arr = SLFramework.FileHelper.GetDirFilePaths("Assets/ZResourcesLib/rolestimeline")

	self._loader = MultiAbLoader.New()

	for i = 0, arr.Length - 1 do
		local path = arr[i]

		if not string.find(path, ".meta") then
			local fileName = SLFramework.FileHelper.GetFileName(path, true)

			self._loader:addPath(string.lower("rolestimeline/" .. fileName))
		end
	end

	self._loader:startLoad(self._dealSkillTimeLine, self)
end

function ResSplitSaveSkillWork:_dealSkillTimeLine()
	for i, tlAssetItem in ipairs(self._loader._resList) do
		local jsonStr = ZProj.SkillTimelineAssetHelper.GeAssetJson(tlAssetItem)

		if not string.nilorempty(jsonStr) then
			local jsonArr = cjson.decode(jsonStr)

			for n = 1, #jsonArr, 2 do
				local tlType = tonumber(jsonArr[n])
				local paramList = jsonArr[n + 1]
				local resName = paramList[1]

				if TimelineEffectType[tlType] and not ResSplitHelper.checkConfigEmpty(string.format("SkillTimeLine:%s", tlAssetItem.ResPath), tlType, resName) then
					local effectUrl = FightHelper.getEffectUrlWithLod(resName)
					local splitType = ResSplitEnum.Folder
					local url = effectUrl

					if string.find(effectUrl, "effects/prefabs/buff/") or string.find(effectUrl, "effects/prefabs/story/") then
						splitType = ResSplitEnum.Path
					else
						local fileName = SLFramework.FileHelper.GetFileName(effectUrl, true)

						url = string.gsub(effectUrl, "/" .. fileName, "")
					end

					if self.includeTimeLineDic[tlAssetItem.ResPath] then
						ResSplitModel.instance:setInclude(splitType, url, false)
					end
				elseif tlType == 16 and not ResSplitHelper.checkConfigEmpty(string.format("SkillTimeLine:%s", tlAssetItem.ResPath), tlType, resName) then
					local resPath = ResUrl.getVideo(resName)

					if self.includeTimeLineDic[tlAssetItem.ResPath] then
						ResSplitModel.instance:setInclude(ResSplitEnum.Video, resName, false)
					end
				end
			end
		end
	end

	self:onDone(true)
end

return ResSplitSaveSkillWork
