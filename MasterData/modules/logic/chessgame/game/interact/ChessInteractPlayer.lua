-- chunkname: @modules/logic/chessgame/game/interact/ChessInteractPlayer.lua

module("modules.logic.chessgame.game.interact.ChessInteractPlayer", package.seeall)

local ChessInteractPlayer = class("ChessInteractPlayer", ChessInteractBase)

function ChessInteractPlayer:onSelected()
	ChessGameController.instance:setClickStatus(ChessGameEnum.SelectPosStatus.SelectObjWaitPos)
	self:calCanWalkArea()

	self._isPlayerSelected = true

	self:refreshPlayerSelected()
end

function ChessInteractPlayer:insertPosToList(x, y, posXList, posYList, dirList)
	local curX, curY = self._target.mo.posX, self._target.mo.posY
	local dir = ChessGameHelper.ToDirection(curX, curY, x, y)

	if ChessGameController.instance:posCanWalk(x, y, dir, self._target.objType) then
		table.insert(posXList, x)
		table.insert(posYList, y)
		table.insert(dirList, dir)
	end
end

function ChessInteractPlayer:onCancelSelect()
	ChessGameController.instance:setClickStatus(ChessGameEnum.SelectPosStatus.None)
	ChessGameController.instance:dispatchEvent(ChessGameEvent.SetNeedChooseDirectionVisible, {
		visible = false
	})

	self._isPlayerSelected = false

	self:refreshPlayerSelected()
end

function ChessInteractPlayer:onSelectPos(x, y)
	if self._isMoving or ChessGameController.instance.eventMgr:isPlayingFlow() then
		return
	end

	local curX, curY = self._target.mo.posX, self._target.mo.posY
	local dir = ChessGameHelper.ToDirection(curX, curY, x, y)

	if (curX == x and math.abs(curY - y) == 1 or curY == y and math.abs(curX - x) == 1) and ChessGameController.instance:posCanWalk(x, y, dir, self._target.objType) then
		if ChessGameController.instance:getClickStatus() ~= ChessGameEnum.SelectPosStatus.CatchObj then
			local optData = {
				param = "",
				type = ChessGameEnum.OptType.Single,
				id = self._target.mo.id,
				direction = ChessGameHelper.ToDirection(curX, curY, x, y)
			}

			ChessGameModel.instance:appendOpt(optData)

			local actId = ChessModel.instance:getActId()
			local episodeId = ChessModel.instance:getEpisodeId()
			local optList = ChessGameModel.instance:getOptList()

			ChessRpcController.instance:sendActBeginRoundRequest(actId, episodeId, optList, self.onMoveSuccess, self)
			ChessGameController.instance:saveTempSelectObj()
			ChessGameController.instance:setSelectObj(nil)
		end
	else
		local clickObj = ChessGameController.instance:getPosCanClickInteract(x, y)

		if clickObj and (curX == x and math.abs(curY - y) == 1 or curY == y and math.abs(curX - x) == 1) then
			if clickObj.config and clickObj.config.interactType ~= ChessGameEnum.InteractType.Role then
				if clickObj.config.canMove and (ChessGameController.instance:getClickStatus() ~= ChessGameEnum.SelectPosStatus.CatchObj or true) then
					AudioMgr.instance:trigger(AudioEnum.VersionActivity2_1ChessGame.play_ui_activity_box_push)
					ChessGameController.instance:setClickStatus(ChessGameEnum.SelectPosStatus.CatchObj)
					ChessGameController.instance:dispatchEvent(ChessGameEvent.SetNeedChooseDirectionVisible, {
						visible = false
					})
					ChessGameModel.instance:setCatchObj(clickObj)
					clickObj:getHandler():withCatch()

					local x, y = clickObj.mo:getXY()
					local catchdir = ChessGameHelper.ToDirection(curX, curY, x, y)
					local posx = (self._target.mo.posX + x) / 2
					local posy = (self._target.mo.posY + y) / 2

					self.moveTo(self, posx, posy, self._refreshNodeArea, self)
					self:faceTo(catchdir)

					return
				end

				if not clickObj.config.touchTrigger then
					return
				end

				if clickObj.config.triggerDir == 0 or clickObj.config.triggerDir == dir then
					if ChessGameInteractModel.instance:checkInteractFinish(clickObj.mo.id) then
						return
					end

					local x, y = clickObj.mo:getXY()
					local catchdir = ChessGameHelper.ToDirection(curX, curY, x, y)

					self:faceTo(catchdir)

					local posx = (self._target.mo.posX + x) / 2
					local posy = (self._target.mo.posY + y) / 2

					local function callback()
						self._isMoving = false

						self.moveTo(self, self._target.mo.posX, self._target.mo.posY, self.calCanWalkArea, self)
					end

					self.moveTo(self, posx, posy, callback, self)
					self:optItem(clickObj)
				end
			else
				ChessGameController.instance:setSelectObj(nil)

				return true
			end
		else
			return
		end
	end
end

function ChessInteractPlayer:optItem(obj)
	if not obj then
		return
	end

	local optData = {
		param = "",
		type = ChessGameEnum.OptType.UseItem,
		id = obj.config.id,
		direction = obj.config.triggerDir
	}

	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_1ChessGame.play_ui_molu_monster_awake)
	ChessGameModel.instance:appendOpt(optData)

	local actId = ChessModel.instance:getActId()
	local episodeId = ChessModel.instance:getEpisodeId()
	local optList = ChessGameModel.instance:getOptList()

	ChessRpcController.instance:sendActBeginRoundRequest(actId, episodeId, optList, self.onOptSuccess, self)
	ChessGameController.instance:saveTempSelectObj()
	ChessGameController.instance:setSelectObj(nil)
end

function ChessInteractPlayer:onMoveBegin()
	ChessGameController.instance:dispatchEvent(ChessGameEvent.SetNeedChooseDirectionVisible, {
		visible = false
	})
end

function ChessInteractPlayer:onMoveSuccess(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	ChessGameController.instance:setSelectObj(nil)
end

function ChessInteractPlayer:onOptSuccess(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end
end

function ChessInteractPlayer:calCanWalkArea()
	if ChessGameModel.instance:isTalking() then
		return
	end

	local x, y = self._target.mo.posX, self._target.mo.posY
	local evtObj = {
		visible = true,
		posXList = {},
		posYList = {},
		dirList = {},
		selfPosX = x,
		selfPosY = y,
		selectType = ChessGameEnum.ChessSelectType.Normal
	}

	self:insertPosToList(x + 1, y, evtObj.posXList, evtObj.posYList, evtObj.dirList)
	self:insertPosToList(x - 1, y, evtObj.posXList, evtObj.posYList, evtObj.dirList)
	self:insertPosToList(x, y + 1, evtObj.posXList, evtObj.posYList, evtObj.dirList)
	self:insertPosToList(x, y - 1, evtObj.posXList, evtObj.posYList, evtObj.dirList)
	ChessGameController.instance:dispatchEvent(ChessGameEvent.SetNeedChooseDirectionVisible, evtObj)
end

function ChessInteractPlayer:moveTo(x, y, callback, callbackObj)
	ChessInteractPlayer.super.moveTo(self, x, y, callback, callbackObj)

	if self._animSelf then
		self._animSelf:Play("jump", 0, 0)
	end
end

function ChessInteractPlayer:showHitAni()
	if self._animSelf then
		self._animSelf:Play("hit", 0, 0)
	end
end

function ChessInteractPlayer:refreshPlayerSelected()
	return
end

function ChessInteractPlayer:_refreshNodeArea()
	local x, y = self._target.mo.posX, self._target.mo.posY
	local evtObj = {
		visible = true,
		posXList = {},
		posYList = {},
		dirList = {},
		selfPosX = x,
		selfPosY = y,
		selectType = ChessGameEnum.ChessSelectType.CatchObj
	}
	local catchObj = ChessGameModel.instance:getCatchObj()

	if not catchObj then
		return
	end

	local objX, objY = catchObj.mo:getXY()

	evtObj.selfPosX = objX
	evtObj.selfPosY = objY

	local nodePos1, nodePos2

	ChessGameModel.instance:cleanCatchObjCanWalkList()

	if x == objX then
		nodePos1 = {
			x = x,
			y = math.max(y, objY) + 1
		}

		if self:catchObjCanWalk(nodePos1) then
			table.insert(evtObj.posXList, objX)
			table.insert(evtObj.posYList, objY + 1)
			table.insert(evtObj.dirList, ChessGameEnum.Direction.Up)

			local objPos = {
				x = objX,
				y = objY + 1
			}

			ChessGameModel.instance:insertCatchObjCanWalkList(objPos)
		end

		nodePos1 = {
			x = x,
			y = math.min(y, objY) - 1
		}

		if self:catchObjCanWalk(nodePos1) then
			table.insert(evtObj.posXList, objX)
			table.insert(evtObj.posYList, objY - 1)
			table.insert(evtObj.dirList, ChessGameEnum.Direction.Down)

			local objPos = {
				x = objX,
				y = objY - 1
			}

			ChessGameModel.instance:insertCatchObjCanWalkList(objPos)
		end

		nodePos1 = {
			x = x - 1,
			y = y
		}
		nodePos2 = {
			x = objX - 1,
			y = objY
		}

		if self:catchObjCanWalk(nodePos1, nodePos2) then
			table.insert(evtObj.posXList, objX - 1)
			table.insert(evtObj.posYList, objY)
			table.insert(evtObj.dirList, ChessGameEnum.Direction.Left)

			local objPos = {
				x = objX - 1,
				y = objY
			}

			ChessGameModel.instance:insertCatchObjCanWalkList(objPos)
		end

		nodePos1 = {
			x = x + 1,
			y = y
		}
		nodePos2 = {
			x = objX + 1,
			y = objY
		}

		if self:catchObjCanWalk(nodePos1, nodePos2) then
			table.insert(evtObj.posXList, objX + 1)
			table.insert(evtObj.posYList, objY)
			table.insert(evtObj.dirList, ChessGameEnum.Direction.Right)

			local objPos = {
				x = objX + 1,
				y = objY
			}

			ChessGameModel.instance:insertCatchObjCanWalkList(objPos)
		end
	else
		nodePos1 = {
			x = x,
			y = y + 1
		}
		nodePos2 = {
			x = objX,
			y = objY + 1
		}

		if self:catchObjCanWalk(nodePos1, nodePos2) then
			table.insert(evtObj.posXList, objX)
			table.insert(evtObj.posYList, objY + 1)
			table.insert(evtObj.dirList, ChessGameEnum.Direction.Up)

			local objPos = {
				x = objX,
				y = objY + 1
			}

			ChessGameModel.instance:insertCatchObjCanWalkList(objPos)
		end

		nodePos1 = {
			x = x,
			y = y - 1
		}
		nodePos2 = {
			x = objX,
			y = objY - 1
		}

		if self:catchObjCanWalk(nodePos1, nodePos2) then
			table.insert(evtObj.posXList, objX)
			table.insert(evtObj.posYList, objY - 1)
			table.insert(evtObj.dirList, ChessGameEnum.Direction.Down)

			local objPos = {
				x = objX,
				y = objY - 1
			}

			ChessGameModel.instance:insertCatchObjCanWalkList(objPos)
		end

		nodePos1 = {
			x = math.min(x, objX) - 1,
			y = y
		}

		if self:catchObjCanWalk(nodePos1) then
			table.insert(evtObj.posXList, objX - 1)
			table.insert(evtObj.posYList, objY)
			table.insert(evtObj.dirList, ChessGameEnum.Direction.Left)

			local objPos = {
				x = objX - 1,
				y = objY
			}

			ChessGameModel.instance:insertCatchObjCanWalkList(objPos)
		end

		nodePos1 = {
			x = math.max(x, objX) + 1,
			y = y
		}

		if self:catchObjCanWalk(nodePos1) then
			table.insert(evtObj.posXList, objX + 1)
			table.insert(evtObj.posYList, objY)
			table.insert(evtObj.dirList, ChessGameEnum.Direction.Right)

			local objPos = {
				x = objX + 1,
				y = objY
			}

			ChessGameModel.instance:insertCatchObjCanWalkList(objPos)
		end
	end

	ChessGameController.instance:dispatchEvent(ChessGameEvent.SetNeedChooseDirectionVisible, evtObj)
end

function ChessInteractPlayer:catchObjCanWalk(nodePos1, nodePos2)
	if nodePos1 and not ChessGameController.instance:posCanWalk(nodePos1.x, nodePos1.y) then
		return false
	end

	if nodePos2 and not ChessGameController.instance:posCanWalk(nodePos2.x, nodePos2.y) then
		return false
	end

	return true
end

function ChessInteractPlayer:onSetPosWithCatchObj(x, y)
	local pos = {
		x = x,
		y = y
	}

	if not ChessGameModel.instance:checkPosCatchObjCanWalk(pos) then
		self:cancelCatchObj(true)

		return
	end

	local catchObj = ChessGameModel.instance:getCatchObj()

	if not catchObj then
		return
	end

	local objX, objY = catchObj.mo:getXY()
	local optData = {
		type = ChessGameEnum.OptType.WithInteract,
		id = self._target.mo.id,
		direction = ChessGameHelper.ToDirection(objX, objY, x, y),
		param = tostring(catchObj.mo.id)
	}

	ChessGameModel.instance:appendOpt(optData)

	local actId = ChessModel.instance:getActId()
	local episodeId = ChessModel.instance:getEpisodeId()
	local optList = ChessGameModel.instance:getOptList()

	ChessRpcController.instance:sendActBeginRoundRequest(actId, episodeId, optList, self.onMoveSuccess, self)
	ChessGameController.instance:saveTempSelectObj()
	ChessGameController.instance:setSelectObj(nil)
end

function ChessInteractPlayer:cancelCatchObj(isAnim)
	if isAnim then
		ChessGameModel.instance:setCatchObj(nil)
		ChessGameModel.instance:cleanCatchObjCanWalkList()
		ChessGameController.instance:dispatchEvent(ChessGameEvent.SetNeedChooseDirectionVisible, {
			visible = false
		})
		self.moveTo(self, self._target.mo.posX, self._target.mo.posY, self.onSelected, self)
	end
end

function ChessInteractPlayer:onAvatarLoaded()
	ChessInteractPlayer.super.onAvatarLoaded(self)

	local loader = self._target.avatar.loader

	if not loader then
		return
	end

	local go = loader:getInstGO()

	if not gohelper.isNil(go) then
		self._animSelf = go:GetComponent(typeof(UnityEngine.Animator))
	end

	self._target.avatar.goSelected = gohelper.findChild(loader:getInstGO(), "piecea/vx_select")

	gohelper.setActive(self._target.avatar.goSelected, true)
	self:refreshPlayerSelected()
end

return ChessInteractPlayer
