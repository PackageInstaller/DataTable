-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Debug\\AVGEditor\\AVGEditor.lua

local AVGEditor = {}

if not IsGLDeclared("AVGEditor") or not AVGEditor then
	GLDeclare("AVGEditor", AVGEditor)
end

function AVGEditor.playAVGCo(section, page, isAuto)
	while SceneManager._doLoading do
		coroutine.wait(0.5)
	end

	UIManager.playAVG(section, page)
end

function AVGEditor.playAVG(section, page, isAuto)
	LuaReload.reload()

	local sectionID = tonumber(section) or 1
	local pageID = tonumber(page) or 1

	AVGEditor._realPlayAVG(sectionID, pageID, isAuto)
end

local TalkScenery = require("UI/TalkScenery")

function AVGEditor._realPlayAVG(sectionID, pageID, isAuto)
	local ResTalkSceneMap = require("ClientData/ResTalkSceneMap")

	if ResTalkSceneMap[sectionID] then
		local targetSceneID = ResTalkSceneMap[sectionID].scene_id

		if targetSceneID and not SceneManager.isSameScene(targetSceneID, SceneManager.mCurSceneID) then
			if GameFsm.isInState(Const.STATE_MAIN_STAGE) then
				local PerformManager = require("Logic/perform/PerformManager")

				PerformManager.stop()
			end

			SceneManager.addLoadScene(targetSceneID)

			local loadedCallback = Functor(AVGEditor._realPlayAVG, sectionID, pageID, isAuto)

			LoadManager.start(loadedCallback)

			return
		end
	end

	local talkBox = UIManager.getUI("talkBox")
	local finishCB

	if talkBox.data ~= nil then
		talkBox._bgID = nil

		TalkScenery.clear()
	else
		talkBox = UIManager.getUI("talkBox", true)
	end

	if isAuto then
		talkBox.autoPlay = true
	else
		talkBox.autoPlay = false
	end

	talkBox:showSection(sectionID, pageID, finishCB)
end

function AVGEditor.hasLogin()
	if CurAvatar then
		return true
	else
		return false
	end
end

function AVGEditor.fakeAvatar()
	local ClientAvatar = require("Avatar/ClientAvatar")
end

function AVGEditor.getResTable(tableName)
	local resTable = require(tableName)
	local testList = {
		1,
		1,
		2,
		3,
		4
	}

	return resTable
end

function AVGEditor.getResTableToArray(tableName)
	local resTable = require(tableName)
	local ret = {}

	if resTable then
		for k, v in pairs(resTable) do
			table.insert(ret, tostring(k))
		end
	end

	return ret
end

return AVGEditor
