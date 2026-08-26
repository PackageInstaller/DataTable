-- chunkname: @modules/logic/dungeon/view/maze/DungeonMazeWordEffectView.lua

module("modules.logic.dungeon.view.maze.DungeonMazeWordEffectView", package.seeall)

local DungeonMazeWordEffectView = class("DungeonMazeWordEffectView", BaseViewExtended)
local testWordPosCfg = {
	{
		id = 1,
		pos = "0#0"
	}
}

function DungeonMazeWordEffectView:onInitView()
	self._leftWordRoot = gohelper.findChild(self.viewGO, "Road/road1/obstacleDialog")
	self._rightWordRoot = gohelper.findChild(self.viewGO, "Road/road2/obstacleDialog")
	self._bottomWordRoot = gohelper.findChild(self.viewGO, "Road/road3/obstacleDialog")
	self._topWordRoot = gohelper.findChild(self.viewGO, "Road/road4/obstacleDialog")
end

function DungeonMazeWordEffectView:onOpen()
	self.rightWordContentGO = self:getResInst(self.viewContainer._viewSetting.otherRes[1], self._rightWordRoot)
	self.rightWordEffect = self:getResInst(self.viewContainer._viewSetting.otherRes[2], self.rightWordContentGO)
	self.leftWordContentGO = self:getResInst(self.viewContainer._viewSetting.otherRes[1], self._leftWordRoot)
	self.leftWordEffect = self:getResInst(self.viewContainer._viewSetting.otherRes[2], self.leftWordContentGO)
	self.bottomWordContentGO = self:getResInst(self.viewContainer._viewSetting.otherRes[1], self._bottomWordRoot)
	self.bottomWordEffect = self:getResInst(self.viewContainer._viewSetting.otherRes[2], self.bottomWordContentGO)
	self.topWordContentGO = self:getResInst(self.viewContainer._viewSetting.otherRes[1], self._topWordRoot)
	self.topWordEffect = self:getResInst(self.viewContainer._viewSetting.otherRes[2], self.topWordContentGO)

	gohelper.setActive(self.leftWordContentGO, false)
	gohelper.setActive(self.leftWordEffect, false)
	gohelper.setActive(self.rightWordContentGO, false)
	gohelper.setActive(self.rightWordEffect, false)
	gohelper.setActive(self.bottomWordContentGO, false)
	gohelper.setActive(self.bottomWordEffect, false)
	gohelper.setActive(self.topWordContentGO, false)
	gohelper.setActive(self.topWordEffect, false)

	self._dirDialogRootMap = self:getUserDataTb_()
	self._dirDialogRootMap[DungeonMazeEnum.dir.left] = self._leftWordRoot
	self._dirDialogRootMap[DungeonMazeEnum.dir.right] = self._rightWordRoot
	self._dirDialogRootMap[DungeonMazeEnum.dir.down] = self._bottomWordRoot
	self._dirDialogRootMap[DungeonMazeEnum.dir.up] = self._topWordRoot
	self._dirWordObjMap = self:getUserDataTb_()
	self._dirWordObjMap[DungeonMazeEnum.dir.left] = self.leftWordContentGO
	self._dirWordObjMap[DungeonMazeEnum.dir.right] = self.rightWordContentGO
	self._dirWordObjMap[DungeonMazeEnum.dir.down] = self.bottomWordContentGO
	self._dirWordObjMap[DungeonMazeEnum.dir.up] = self.topWordContentGO
	self._dirWordEffectObjMap = self:getUserDataTb_()
	self._dirWordEffectObjMap[DungeonMazeEnum.dir.left] = self.leftWordEffect
	self._dirWordEffectObjMap[DungeonMazeEnum.dir.right] = self.rightWordEffect
	self._dirWordEffectObjMap[DungeonMazeEnum.dir.down] = self.bottomWordEffect
	self._dirWordEffectObjMap[DungeonMazeEnum.dir.up] = self.topWordEffect
	self._showEffectDirs = {}
end

function DungeonMazeWordEffectView:addEvents()
	self.addEventCb(self, DungeonMazeController.instance, DungeonMazeEvent.ShowMazeObstacleDialog, self.showWordEffect, self)
end

function DungeonMazeWordEffectView:showWordEffect(dir, showDialog, done)
	self._showEffectDirs = self._showEffectDirs or {}

	if self._showEffectDone then
		self._showEffectDone = self._showEffectDone or {}
	end

	self._showEffectDirs[dir] = showDialog
	self._showEffectDone[dir] = done

	self:_refreshWordEffect()
end

function DungeonMazeWordEffectView:_refreshWordEffect()
	for _, dir in pairs(DungeonMazeEnum.dir) do
		gohelper.setActive(self._dirDialogRootMap[dir], self._showEffectDirs[dir])

		if not string.nilorempty(self._showEffectDirs[dir]) then
			if self._wordEffectGo then
				gohelper.destroy(self._wordEffectGo)

				self._wordEffectGo = nil
			end

			local contentGo = self._dirWordObjMap[dir]
			local wordEffectGo = self._dirWordEffectObjMap[dir]

			self._wordEffectGo = gohelper.cloneInPlace(contentGo)

			gohelper.setActive(self._wordEffectGo, true)

			local wordEffectCofig = {
				tpye = 1,
				desc = self._showEffectDirs[dir]
			}
			local wordEffectPosConfig = testWordPosCfg[1]
			local pos = string.splitToNumber(wordEffectPosConfig.pos, "#")

			recthelper.setAnchor(self._wordEffectGo.transform, pos[1], pos[2])
			MonoHelper.addNoUpdateLuaComOnceToGo(self._wordEffectGo, DungeonMazeWordEffectComp, {
				co = wordEffectCofig,
				res = wordEffectGo,
				done = self._showEffectDone[dir]
			})
		else
			local contentGo = self._dirWordObjMap[dir]
			local wordEffectGo = self._dirWordEffectObjMap[dir]

			gohelper.setActive(contentGo, false)
			gohelper.setActive(wordEffectGo, false)
		end
	end
end

function DungeonMazeWordEffectView:onClose()
	return
end

return DungeonMazeWordEffectView
