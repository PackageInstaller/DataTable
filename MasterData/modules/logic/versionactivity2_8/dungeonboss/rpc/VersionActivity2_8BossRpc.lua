-- chunkname: @modules/logic/versionactivity2_8/dungeonboss/rpc/VersionActivity2_8BossRpc.lua

module("modules.logic.versionactivity2_8.dungeonboss.rpc.VersionActivity2_8BossRpc", package.seeall)

local VersionActivity2_8BossRpc = class("VersionActivity2_8BossRpc", BaseRpc)

function VersionActivity2_8BossRpc:sendBossFightResetChapterRequest(chapterId, callback, callbackObj)
	local req = BossFightModule_pb.BossFightResetChapterRequest()

	req.chapterId = chapterId

	self:sendMsg(req, callback, callbackObj)
end

function VersionActivity2_8BossRpc:onReceiveBossFightResetChapterReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	DungeonModel.instance:resetEpisodeInfoByChapterId(DungeonEnum.ChapterId.BossStory)
	HeroGroupModel.instance:clearCustomHeroGroup(VersionActivity2_8BossEnum.HeroGroupId.First)
	HeroGroupModel.instance:clearCustomHeroGroup(VersionActivity2_8BossEnum.HeroGroupId.Second)
	DungeonController.instance:dispatchEvent(DungeonEvent.BossStoryReset)
end

VersionActivity2_8BossRpc.instance = VersionActivity2_8BossRpc.New()

return VersionActivity2_8BossRpc
