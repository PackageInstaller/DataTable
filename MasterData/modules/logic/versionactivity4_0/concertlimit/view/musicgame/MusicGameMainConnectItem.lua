-- chunkname: @modules/logic/versionactivity4_0/concertlimit/view/musicgame/MusicGameMainConnectItem.lua

module("modules.logic.versionactivity4_0.concertlimit.view.musicgame.MusicGameMainConnectItem", package.seeall)

local MusicGameMainConnectItem = class("MusicGameMainConnectItem", LuaCompBase)

function MusicGameMainConnectItem:init(go)
	self.go = go
	self._goline = gohelper.findChild(self.go, "line")
	self._gobend = gohelper.findChildImage(self.go, "bend")
	self._gostart = gohelper.findChild(self.go, "start")
	self._goend = gohelper.findChild(self.go, "end")

	self:_initItem()
end

function MusicGameMainConnectItem:_initItem()
	gohelper.setActive(self.go, false)
end

function MusicGameMainConnectItem:refresh(blockId)
	local startBlockId, endBlockId = MusicGameModel.instance:getBlockConnects(blockId)
	local blockMo = MusicGameModel.instance:getBlockDataById(blockId)

	if startBlockId then
		gohelper.setActive(self.go, true)

		local startBlockMo = MusicGameModel.instance:getBlockDataById(startBlockId)
		local inDir = MusicGameUtil.getBlockConnectDir(startBlockMo.x, startBlockMo.y, blockMo.x, blockMo.y)

		if endBlockId then
			gohelper.setActive(self._gostart, false)
			gohelper.setActive(self._goend, false)

			local endBlockMo = MusicGameModel.instance:getBlockDataById(endBlockId)
			local outDir = MusicGameUtil.getBlockConnectDir(blockMo.x, blockMo.y, endBlockMo.x, endBlockMo.y)

			if inDir == outDir then
				gohelper.setActive(self._gobend, false)
				gohelper.setActive(self._goline, true)
				transformhelper.setLocalRotation(self._goline.transform, 0, 0, (inDir == MusicGameEnum.Direction.Up or inDir == MusicGameEnum.Direction.Down or nil) and 90)
			else
				gohelper.setActive(self._gobend, true)
				gohelper.setActive(self._goline, false)
				transformhelper.setLocalRotation(self._gobend.transform, 0, 0, inDir - outDir % 4 == 1 and 90 * (3 - inDir) or -90 * inDir)
			end
		else
			gohelper.setActive(self._gostart, false)
			gohelper.setActive(self._goend, true)
			gohelper.setActive(self._gobend, false)
			gohelper.setActive(self._goline, false)
			transformhelper.setLocalRotation(self._goend.transform, 0, 0, 90 * (2 - inDir))
		end
	elseif endBlockId then
		local endBlockMo = MusicGameModel.instance:getBlockDataById(endBlockId)
		local outDir = MusicGameUtil.getBlockConnectDir(blockMo.x, blockMo.y, endBlockMo.x, endBlockMo.y)

		gohelper.setActive(self.go, true)
		gohelper.setActive(self._gostart, true)
		gohelper.setActive(self._goend, false)
		gohelper.setActive(self._gobend, false)
		gohelper.setActive(self._goline, false)
		transformhelper.setLocalRotation(self._gostart.transform, 0, 0, 90 * (3 - outDir))
	else
		gohelper.setActive(self.go, false)
	end
end

function MusicGameMainConnectItem:destroy()
	return
end

return MusicGameMainConnectItem
