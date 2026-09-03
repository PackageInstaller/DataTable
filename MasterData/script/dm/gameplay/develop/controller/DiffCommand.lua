-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/controller/DiffCommand.lua

DiffCommand = class("DiffCommand", legs.Command, _M)

function DiffCommand:execute(event)
	local data = event:getData()
	local developSystem = self:getInjector():getInstance(DevelopSystem)
	local shopSystem = self:getInjector():getInstance(ShopSystem)
	local systemKeeper = self:getInjector():getInstance(SystemKeeper)
	local stageSystem = self:getInjector():getInstance(StageSystem)
	local mazeSystem = self:getInjector():getInstance(MazeSystem)
	local buildingSystem = self:getInjector():getInstance(BuildingSystem)

	if data.del then
		developSystem:syncDeleteData(data.del)
		shopSystem:syncDeleteData(data.del)
		buildingSystem:syncDeleteBuff(data.del)
	end

	if data.diff and data.diff.player then
		developSystem:syncPlayer(data.diff.player, true)
		shopSystem:syncDiffShop(data.diff)

		if data.diff.player.galleryMemories then
			for type, value in pairs(data.diff.player.galleryMemories) do
				if type == GalleryMemoryType.ACTIVI then
					local customDataSystem = self:getInjector():getInstance(CustomDataSystem)

					customDataSystem:setValue(PrefixType.kGlobal, "GalleryCGRed", "1")
				end
			end
		end
	end

	local diff = data.diff

	if diff.player and diff.player.playerClub and diff.player.playerClub.playerBSInfo then
		local clubBashenSystem = self:getInjector():getInstance(ClubBashenSystem)

		clubBashenSystem:synchronize(diff.player.playerClub.playerBSInfo)

		if diff.player.playerClub.playerBSInfo.bigPrize then
			clubBashenSystem:synchronizeBigPrize(diff.player.playerClub.playerBSInfo.bigPrize)
		end

		if diff.player.playerClub.playerBSInfo.manualFinish ~= nil then
			clubBashenSystem:synchronizeManualFinish(diff.player.playerClub.playerBSInfo.manualFinish)
		end
	end

	systemKeeper:backupUnlockSystem()
	self:dispatch(Event:new(EVT_REDPOINT_REFRESH))
	self:dispatch(Event:new(EVT_RESOURCEDOUBLE_REFRESH))
end
