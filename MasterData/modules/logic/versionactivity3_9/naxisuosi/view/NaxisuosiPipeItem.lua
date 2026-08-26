-- chunkname: @modules/logic/versionactivity3_9/naxisuosi/view/NaxisuosiPipeItem.lua

module("modules.logic.versionactivity3_9.naxisuosi.view.NaxisuosiPipeItem", package.seeall)

local NaxisuosiPipeItem = class("NaxisuosiPipeItem", LuaCompBase)

function NaxisuosiPipeItem:init(go)
	self.viewGO = go
	self._goWall = gohelper.findChild(self.viewGO, "#go_Wall")
	self._goPath = gohelper.findChild(self.viewGO, "#go_Path")
	self._goCorrect = gohelper.findChild(self.viewGO, "#go_Path/#go_Correct")
	self._goError = gohelper.findChild(self.viewGO, "#go_Path/#go_Error")
	self._goStart = gohelper.findChild(self.viewGO, "#go_Start")
	self._goPiece = gohelper.findChild(self.viewGO, "#go_Piece")
	self._imagePiece = gohelper.findChildImage(self.viewGO, "#go_Piece/#image_Piece")
	self._goExit = gohelper.findChild(self.viewGO, "#go_Exit")
	self._goClickArea = gohelper.findChild(self.viewGO, "#go_ClickArea")
	self._goStartType1 = gohelper.findChild(self.viewGO, "#go_Start/#image_Piece_orange")
	self._goStartType2 = gohelper.findChild(self.viewGO, "#go_Start/#image_Piece_blue")
	self._goExitType1 = gohelper.findChild(self.viewGO, "#go_Exit/#image_Piece_orange")
	self._goExitType2 = gohelper.findChild(self.viewGO, "#go_Exit/#image_Piece_blue")
	self._goExitNormal = gohelper.findChild(self.viewGO, "#go_Exit/#image_Piece_gray")
	self._exitTypeList = {
		self._goExitType1,
		self._goExitType2
	}
	self._startTypeList = {
		self._goStartType1,
		self._goStartType2
	}
	self.tf = self._goPiece.transform

	self:_editableInitView()

	self._itemStartConnectList = self:_buildConnectNodeList(self._goStart)
	self._itemExitConnectList = self:_buildConnectNodeList(self._goExit)
end

function NaxisuosiPipeItem:addEventListeners()
	return
end

function NaxisuosiPipeItem:removeEventListeners()
	return
end

function NaxisuosiPipeItem:onStart()
	return
end

function NaxisuosiPipeItem:onDestroy()
	return
end

function NaxisuosiPipeItem:_editableInitView()
	gohelper.setActive(self._goWall, false)
	gohelper.setActive(self._goPath, false)
	gohelper.setActive(self._goStart, false)
	gohelper.setActive(self._goPiece, false)
	gohelper.setActive(self._goExit, false)

	self._animatorPiece = gohelper.findChildComponent(self.viewGO, "#go_Piece", gohelper.Type_Animator)
	self._animatorStart = gohelper.findChildComponent(self.viewGO, "#go_Start/#go_connect", gohelper.Type_Animator)
	self._animatorExit = gohelper.findChildComponent(self.viewGO, "#go_Exit/#go_connect", gohelper.Type_Animator)
	self._animatorComplete = gohelper.findChildComponent(self.viewGO, "#go_Exit", gohelper.Type_Animator)
	self._animatorPath = gohelper.findChildComponent(self.viewGO, "#go_Path", gohelper.Type_Animator)
end

function NaxisuosiPipeItem:_buildConnectNodeList(parentGo)
	local connectGo = gohelper.findChild(parentGo, "#go_connect")

	if not connectGo then
		return {}
	end

	local nodeMap = {
		node_left = NaxisuosiPipeEnum.dir.left,
		node_right = NaxisuosiPipeEnum.dir.right,
		node_up = NaxisuosiPipeEnum.dir.up,
		node_down = NaxisuosiPipeEnum.dir.down
	}
	local nodeList = {}

	for nodeName, dir in pairs(nodeMap) do
		local nodeGo = gohelper.findChild(connectGo, nodeName)

		if nodeGo then
			local item = {
				go = nodeGo,
				grey = gohelper.findChild(nodeGo, "#image_Piece_grey"),
				orange = gohelper.findChild(nodeGo, "#image_Piece_orange"),
				blue = gohelper.findChild(nodeGo, "#image_Piece_blue"),
				red = gohelper.findChild(nodeGo, "#image_Piece_red")
			}

			gohelper.setActive(item.grey, false)
			gohelper.setActive(item.orange, false)
			gohelper.setActive(item.blue, false)
			gohelper.setActive(item.red, false)
			gohelper.setActive(nodeGo, false)

			nodeList[dir] = item
		end
	end

	return nodeList
end

function NaxisuosiPipeItem:_isDirConnectedToWrong(mo, dir)
	if not mo or not mo.connectSet or not mo.connectSet[dir] then
		return false
	end

	local dirDelta = {
		[NaxisuosiPipeEnum.dir.left] = {
			-1,
			0
		},
		[NaxisuosiPipeEnum.dir.right] = {
			1,
			0
		},
		[NaxisuosiPipeEnum.dir.up] = {
			0,
			1
		},
		[NaxisuosiPipeEnum.dir.down] = {
			0,
			-1
		}
	}
	local delta = dirDelta[dir]

	if not delta then
		return false
	end

	local nextMo = NaxisuosiPipeModel.instance:getData(mo.x + delta[1], mo.y + delta[2])

	return nextMo ~= nil and nextMo.typeId == NaxisuosiPipeEnum.type.wrong
end

function NaxisuosiPipeItem:_isDirectlyConnectedToWrong(mo)
	if not mo or not mo.connectSet then
		return false
	end

	for dir, _ in pairs(mo.connectSet) do
		if self:_isDirConnectedToWrong(mo, dir) then
			return true
		end
	end

	return false
end

function NaxisuosiPipeItem:_getBranchPathInfo(mo)
	local visited = {}

	visited[mo] = true

	local queue = {
		mo
	}
	local hasFirst = false
	local connectLastCount = 0
	local hasWrong = false
	local dirDelta = {
		[NaxisuosiPipeEnum.dir.left] = {
			-1,
			0
		},
		[NaxisuosiPipeEnum.dir.right] = {
			1,
			0
		},
		[NaxisuosiPipeEnum.dir.up] = {
			0,
			1
		},
		[NaxisuosiPipeEnum.dir.down] = {
			0,
			-1
		}
	}
	local isStart = true

	while #queue > 0 do
		local cur = table.remove(queue, 1)

		if cur.typeId == NaxisuosiPipeEnum.type.first then
			hasFirst = true
		elseif cur.typeId == NaxisuosiPipeEnum.type.connect or cur.typeId == NaxisuosiPipeEnum.type.last then
			connectLastCount = connectLastCount + 1

			if cur.typeId == NaxisuosiPipeEnum.type.connect then
				if cur.hasWrongNode then
					hasWrong = true
				end

				if cur.connectSet then
					for dir, _ in pairs(cur.connectSet) do
						local delta = dirDelta[dir]

						if delta then
							local nextMo = NaxisuosiPipeModel.instance:getData(cur.x + delta[1], cur.y + delta[2])

							if nextMo and nextMo.typeId == NaxisuosiPipeEnum.type.wrong then
								hasWrong = true
							end
						end
					end
				end
			end
		end

		local isEntryStop = cur.typeId == NaxisuosiPipeEnum.type.first or cur.typeId == NaxisuosiPipeEnum.type.last or cur.typeId == NaxisuosiPipeEnum.type.connect

		if (isStart or not isEntryStop) and cur.connectSet then
			for dir, _ in pairs(cur.connectSet) do
				local delta = dirDelta[dir]

				if delta then
					local nextMo = NaxisuosiPipeModel.instance:getData(cur.x + delta[1], cur.y + delta[2])

					if nextMo and not visited[nextMo] and nextMo.typeId ~= NaxisuosiPipeEnum.type.wrong then
						visited[nextMo] = true

						table.insert(queue, nextMo)
					end
				end
			end
		end

		isStart = false
	end

	local isBranch = not hasFirst and connectLastCount <= 1

	return isBranch, hasWrong
end

function NaxisuosiPipeItem:_getEffectiveStatus(mo)
	if mo.status == NaxisuosiPipeEnum.LineStatus.Connect or mo.status == NaxisuosiPipeEnum.LineStatus.Error then
		local isBranch, hasWrong = self:_getBranchPathInfo(mo)

		if isBranch then
			if hasWrong then
				if self:_isDirectlyConnectedToWrong(mo) then
					return NaxisuosiPipeEnum.LineStatus.Error
				end

				return NaxisuosiPipeEnum.LineStatus.Connect
			end

			return NaxisuosiPipeEnum.LineStatus.Normal
		end

		if mo.status == NaxisuosiPipeEnum.LineStatus.Error and self:_isDirectlyConnectedToWrong(mo) then
			return NaxisuosiPipeEnum.LineStatus.Error
		end

		return NaxisuosiPipeEnum.LineStatus.Connect
	end

	if mo.status == NaxisuosiPipeEnum.LineStatus.Normal then
		local isBranch, hasWrong = self:_getBranchPathInfo(mo)

		if isBranch and hasWrong then
			if self:_isDirectlyConnectedToWrong(mo) then
				return NaxisuosiPipeEnum.LineStatus.Error
			end

			return NaxisuosiPipeEnum.LineStatus.Connect
		end
	end

	return mo.status
end

function NaxisuosiPipeItem:_buildEffectiveConnectKey(mo)
	local dirs = {}

	for dir, _ in pairs(mo.connectSet or {}) do
		if not self:_isDirConnectedToWrong(mo, dir) then
			table.insert(dirs, dir)
		end
	end

	table.sort(dirs)

	return table.concat(dirs, ",")
end

function NaxisuosiPipeItem:_refreshEntryConnectNodes(mo)
	local nodeList
	local isLast = false

	if mo.typeId == NaxisuosiPipeEnum.type.first then
		nodeList = self._itemStartConnectList
	elseif mo.typeId == NaxisuosiPipeEnum.type.last then
		nodeList = self._itemExitConnectList
		isLast = true
	end

	if not nodeList then
		return
	end

	local mapType = NaxisuosiPipeModel.instance:getMapType()
	local isConnectedToFirst = mo.status == NaxisuosiPipeEnum.LineStatus.Connect or mo.status == NaxisuosiPipeEnum.LineStatus.Error

	for dir, item in pairs(nodeList) do
		local isConnected = mo.connectSet[dir] ~= nil

		if isConnected and self:_isDirConnectedToWrong(mo, dir) then
			isConnected = false
		end

		gohelper.setActive(item.go, isConnected)

		if isConnected then
			gohelper.setActive(item.grey, false)
			gohelper.setActive(item.orange, false)
			gohelper.setActive(item.blue, false)
			gohelper.setActive(item.red, false)

			if isLast and not isConnectedToFirst then
				gohelper.setActive(item.grey, true)
			elseif mapType == NaxisuosiPipeEnum.MapType.Orange then
				gohelper.setActive(item.orange, true)
			else
				gohelper.setActive(item.blue, true)
			end
		end
	end
end

function NaxisuosiPipeItem:initItem(mo)
	if not mo or mo.typeId == 0 then
		self:_hideAll()

		return
	end

	gohelper.setActive(self._goWall, mo.typeId == NaxisuosiPipeEnum.type.wrong)
	gohelper.setActive(self._goStart, mo.typeId == NaxisuosiPipeEnum.type.first)
	gohelper.setActive(self._goExit, mo.typeId == NaxisuosiPipeEnum.type.last)
	gohelper.setActive(self._goPath, mo.typeId == NaxisuosiPipeEnum.type.connect)

	local isConnectType = mo.typeId == NaxisuosiPipeEnum.type.connect

	if isConnectType then
		self:refreshAnim(mo, self._lastConnectedStatus == nil)
	end

	local mapType = NaxisuosiPipeModel.instance:getMapType()

	if mo.typeId == NaxisuosiPipeEnum.type.first then
		for type, typeGo in ipairs(self._startTypeList) do
			gohelper.setActive(typeGo, type == mapType)
		end
	elseif mo.typeId == NaxisuosiPipeEnum.type.last then
		for type, typeGo in ipairs(self._exitTypeList) do
			gohelper.setActive(typeGo, type == mapType)
		end

		gohelper.setActive(self._goExitNormal, false)
	end

	if mo.typeId == NaxisuosiPipeEnum.type.first or mo.typeId == NaxisuosiPipeEnum.type.last then
		self:_refreshEntryConnectNodes(mo)

		if not self._lastEntryStatus then
			self:refreshAnim(mo, true)
		end
	end

	local isPipe = NaxisuosiPipeEnum.pathConn[mo.typeId]

	gohelper.setActive(self._goPiece, isPipe)

	if isPipe then
		local originalStatus = mo.status

		mo.status = self:_getEffectiveStatus(mo)

		UISpriteSetMgr.instance:setV3a9NaxiSuosiSprite(self._imagePiece, mo:getStatusRes(), true)

		mo.status = originalStatus

		self:refreshAnim(mo, self._lastPieceStatus == nil)
	end

	self:syncRotation(mo)
end

function NaxisuosiPipeItem:_hideAll()
	gohelper.setActive(self._goWall, false)
	gohelper.setActive(self._goPath, false)
	gohelper.setActive(self._goStart, false)
	gohelper.setActive(self._goPiece, false)
	gohelper.setActive(self._goExit, false)
end

function NaxisuosiPipeItem:initConnectObj(mo)
	if not mo then
		return
	end

	if NaxisuosiPipeEnum.pathConn[mo.typeId] then
		local originalStatus = mo.status

		mo.status = self:_getEffectiveStatus(mo)

		UISpriteSetMgr.instance:setV3a9NaxiSuosiSprite(self._imagePiece, mo:getStatusRes(), true)

		mo.status = originalStatus

		self:refreshAnim(mo, false)
	elseif mo.typeId == NaxisuosiPipeEnum.type.connect then
		self:refreshAnim(mo, false)
	end

	if mo.typeId == NaxisuosiPipeEnum.type.first or mo.typeId == NaxisuosiPipeEnum.type.last then
		self:_refreshEntryConnectNodes(mo)
		self:refreshAnim(mo, false)
	end
end

function NaxisuosiPipeItem:syncRotation(mo)
	if mo then
		local rotation = mo:getRotation()

		transformhelper.setLocalRotation(self.tf, 0, 0, rotation)

		if NaxisuosiPipeEnum.pathConn[mo.typeId] then
			AudioMgr.instance:trigger(AudioEnum3_9.Naxisuosi.play_ui_shiji_route_connect_loop)
		end
	end
end

function NaxisuosiPipeItem:refreshAnim(mo, isInit)
	if not mo then
		return
	end

	local isConnectType = mo.typeId == NaxisuosiPipeEnum.type.connect
	local isPipeType = NaxisuosiPipeEnum.pathConn[mo.typeId] ~= nil
	local isFirstType = mo.typeId == NaxisuosiPipeEnum.type.first
	local isLastType = mo.typeId == NaxisuosiPipeEnum.type.last

	if not isConnectType and not isPipeType and not isFirstType and not isLastType then
		return
	end

	local animator

	if isConnectType then
		animator = self._animatorPath
	elseif isPipeType then
		animator = self._animatorPiece
	elseif isFirstType then
		animator = self._animatorStart
	elseif isLastType then
		animator = self._animatorExit
	end

	if not animator or gohelper.isNil(animator) then
		return
	end

	animator.enabled = true

	local animName

	if isConnectType then
		local isConnected = mo.status == NaxisuosiPipeEnum.LineStatus.Connect or mo.status == NaxisuosiPipeEnum.LineStatus.Error
		local isBranch = self:_getBranchPathInfo(mo)

		if isBranch then
			isConnected = false
		end

		if isInit then
			animName = isConnected and "idle2" or "idle1"

			animator:Play(animName, 0, 0)
			logNormal(string.format("[NaxisuosiPipeItem] refreshAnim init x:%d y:%d status:%d isConnected:%s anim:%s", mo.x, mo.y, mo.status, tostring(isConnected), animName))
		elseif isConnected ~= self._lastConnectedStatus then
			animName = isConnected and "switch2" or "switch1"

			animator:Play(animName, 0, 0)

			if isConnected and not self._lastConnectedStatus then
				AudioMgr.instance:trigger(AudioEnum3_9.Naxisuosi.play_ui_heduonie3_9_complete)
			end

			logNormal(string.format("[NaxisuosiPipeItem] refreshAnim switch x:%d y:%d prev:%s cur:%s anim:%s", mo.x, mo.y, tostring(self._lastConnectedStatus), tostring(isConnected), animName))
		else
			logNormal(string.format("[NaxisuosiPipeItem] refreshAnim skip x:%d y:%d isConnected:%s (no change)", mo.x, mo.y, tostring(isConnected)))
		end

		self._lastConnectedStatus = isConnected
	elseif isFirstType then
		local curConnectKey = self:_buildEffectiveConnectKey(mo)

		if isInit then
			logNormal(string.format("[NaxisuosiPipeItem] refreshAnim init(entry) x:%d y:%d status:%d connectKey:%s", mo.x, mo.y, mo.status, curConnectKey))
		elseif curConnectKey ~= self._lastEntryConnectKey then
			local wasEmpty = self._lastEntryConnectKey == nil or self._lastEntryConnectKey == ""

			animName = wasEmpty and curConnectKey ~= "" and "open" or "refresh"

			animator:Play(animName, 0, 0)
			logNormal(string.format("[NaxisuosiPipeItem] refreshAnim switch(entry) x:%d y:%d status:%d prevKey:%s curKey:%s anim:%s", mo.x, mo.y, mo.status, tostring(self._lastEntryConnectKey), curConnectKey, animName))
		else
			logNormal(string.format("[NaxisuosiPipeItem] refreshAnim skip(entry) x:%d y:%d connectKey:%s (no change)", mo.x, mo.y, curConnectKey))
		end

		self._lastEntryStatus = mo.status
		self._lastEntryConnectKey = curConnectKey
	elseif isLastType then
		local curConnectKey = self:_buildEffectiveConnectKey(mo)
		local isCleared = mo.status == NaxisuosiPipeEnum.LineStatus.Connect
		local isClearedTransition = isCleared and self._lastEntryStatus ~= NaxisuosiPipeEnum.LineStatus.Connect
		local completeAnimator = self._animatorComplete

		if isInit then
			if completeAnimator and not gohelper.isNil(completeAnimator) then
				completeAnimator.enabled = true

				completeAnimator:Play("idle", 0, 0)
			end

			logNormal(string.format("[NaxisuosiPipeItem] refreshAnim init(exit) x:%d y:%d status:%d connectKey:%s", mo.x, mo.y, mo.status, curConnectKey))
		else
			local played = false

			if curConnectKey ~= self._lastEntryConnectKey then
				local wasEmpty = self._lastEntryConnectKey == nil or self._lastEntryConnectKey == ""

				animName = wasEmpty and curConnectKey ~= "" and "open" or "refresh"

				animator:Play(animName, 0, 0)

				played = true

				logNormal(string.format("[NaxisuosiPipeItem] refreshAnim switch(exit) x:%d y:%d status:%d prevKey:%s curKey:%s anim:%s", mo.x, mo.y, mo.status, tostring(self._lastEntryConnectKey), curConnectKey, animName))
			end

			if isClearedTransition then
				if completeAnimator and not gohelper.isNil(completeAnimator) then
					completeAnimator.enabled = true

					completeAnimator:Play("complete", 0, 0)
				end

				played = true

				logNormal(string.format("[NaxisuosiPipeItem] refreshAnim complete(exit) x:%d y:%d status:%d", mo.x, mo.y, mo.status))
			end

			if not played then
				logNormal(string.format("[NaxisuosiPipeItem] refreshAnim skip(exit) x:%d y:%d status:%d connectKey:%s (no change)", mo.x, mo.y, mo.status, curConnectKey))
			end
		end

		self._lastEntryStatus = mo.status
		self._lastEntryConnectKey = curConnectKey
	else
		local status = self:_getEffectiveStatus(mo)

		if isInit then
			animName = status == NaxisuosiPipeEnum.LineStatus.Error and "error" or "idle"

			animator:Play(animName, 0, 0)
			logNormal(string.format("[NaxisuosiPipeItem] refreshAnim init(piece) x:%d y:%d status:%d anim:%s", mo.x, mo.y, status, animName))
		elseif status ~= self._lastPieceStatus then
			animName = status == NaxisuosiPipeEnum.LineStatus.Error and "error" or "idle"

			animator:Play(animName, 0, 0)
			logNormal(string.format("[NaxisuosiPipeItem] refreshAnim switch(piece) x:%d y:%d prev:%d cur:%d anim:%s", mo.x, mo.y, self._lastPieceStatus or -1, status, animName))
		else
			logNormal(string.format("[NaxisuosiPipeItem] refreshAnim skip(piece) x:%d y:%d status:%d (no change)", mo.x, mo.y, status))
		end

		self._lastPieceStatus = status
	end
end

NaxisuosiPipeItem.prefabPath = nil

return NaxisuosiPipeItem
