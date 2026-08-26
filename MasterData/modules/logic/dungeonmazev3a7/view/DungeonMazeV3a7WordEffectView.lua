-- chunkname: @modules/logic/dungeonmazev3a7/view/DungeonMazeV3a7WordEffectView.lua

module("modules.logic.dungeonmazev3a7.view.DungeonMazeV3a7WordEffectView", package.seeall)

local DungeonMazeV3a7WordEffectView = class("DungeonMazeV3a7WordEffectView", BaseViewExtended)
local testWordPosCfg = {
	{
		id = 1,
		pos = "0#0"
	}
}

function DungeonMazeV3a7WordEffectView:onInitView()
	self._leftWordRoot = gohelper.findChild(self.viewGO, "Road/road1/obstacleDialog")
	self._rightWordRoot = gohelper.findChild(self.viewGO, "Road/road2/obstacleDialog")
	self._bottomWordRoot = gohelper.findChild(self.viewGO, "Road/road3/obstacleDialog")
	self._topWordRoot = gohelper.findChild(self.viewGO, "Road/road4/obstacleDialog")
	self._goRoad = gohelper.findChild(self.viewGO, "Road")
	self._dialogParentMap = self:getUserDataTb_()
	self._dialogParentMap[self._leftWordRoot] = self._leftWordRoot.transform.parent
	self._dialogParentMap[self._rightWordRoot] = self._rightWordRoot.transform.parent
	self._dialogParentMap[self._bottomWordRoot] = self._bottomWordRoot.transform.parent
	self._dialogParentMap[self._topWordRoot] = self._topWordRoot.transform.parent
end

function DungeonMazeV3a7WordEffectView:onOpen()
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
	self._dirDialogRootMap[DungeonMazeV3a7Enum.dir.left] = self._leftWordRoot
	self._dirDialogRootMap[DungeonMazeV3a7Enum.dir.right] = self._rightWordRoot
	self._dirDialogRootMap[DungeonMazeV3a7Enum.dir.down] = self._bottomWordRoot
	self._dirDialogRootMap[DungeonMazeV3a7Enum.dir.up] = self._topWordRoot
	self._dirWordObjMap = self:getUserDataTb_()
	self._dirWordObjMap[DungeonMazeV3a7Enum.dir.left] = self.leftWordContentGO
	self._dirWordObjMap[DungeonMazeV3a7Enum.dir.right] = self.rightWordContentGO
	self._dirWordObjMap[DungeonMazeV3a7Enum.dir.down] = self.bottomWordContentGO
	self._dirWordObjMap[DungeonMazeV3a7Enum.dir.up] = self.topWordContentGO
	self._dirWordEffectObjMap = self:getUserDataTb_()
	self._dirWordEffectObjMap[DungeonMazeV3a7Enum.dir.left] = self.leftWordEffect
	self._dirWordEffectObjMap[DungeonMazeV3a7Enum.dir.right] = self.rightWordEffect
	self._dirWordEffectObjMap[DungeonMazeV3a7Enum.dir.down] = self.bottomWordEffect
	self._dirWordEffectObjMap[DungeonMazeV3a7Enum.dir.up] = self.topWordEffect
	self._showEffectDirs = {}
end

function DungeonMazeV3a7WordEffectView:addEvents()
	self.addEventCb(self, DungeonMazeV3a7Controller.instance, DungeonMazeV3a7Event.ShowMazeObstacleDialog, self.showWordEffect, self)
end

function DungeonMazeV3a7WordEffectView:showWordEffect(dir, showDialog, done)
	self._showEffectDirs = self._showEffectDirs or {}

	if self._showEffectDone then
		self._showEffectDone = self._showEffectDone or {}
	end

	self._showEffectDirs[dir] = showDialog
	self._showEffectDone[dir] = done

	self:_refreshWordEffect()
end

function DungeonMazeV3a7WordEffectView:_refreshWordEffect()
	for _, dir in pairs(DungeonMazeV3a7Enum.dir) do
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
			MonoHelper.addNoUpdateLuaComOnceToGo(self._wordEffectGo, DungeonMazeV3a7WordEffectComp, {
				co = wordEffectCofig,
				res = wordEffectGo,
				done = self._showEffectDone[dir]
			})

			self._dirDialogRootMap[dir].transform.parent = self.viewGO.transform

			gohelper.setSiblingAfter(self._dirDialogRootMap[dir], self._goRoad)
		else
			local contentGo = self._dirWordObjMap[dir]
			local wordEffectGo = self._dirWordEffectObjMap[dir]

			gohelper.setActive(contentGo, false)
			gohelper.setActive(wordEffectGo, false)

			self._dirDialogRootMap[dir].transform.parent = self._dialogParentMap[self._dirDialogRootMap[dir]]
		end
	end
end

function DungeonMazeV3a7WordEffectView:onClose()
	return
end

return DungeonMazeV3a7WordEffectView
