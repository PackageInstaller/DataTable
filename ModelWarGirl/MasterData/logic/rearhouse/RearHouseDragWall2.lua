-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Logic\\RearHouse\\RearHouseDragWall2.lua

local RearHouseDragWall = require("Logic/RearHouse/RearHouseDragWall")
local CameraManager = Framework.CameraSystem.CameraManager
local strClassName = "RearHouseDragWall2"
local RearHouseDragWall2 = Class(strClassName, RearHouseDragWall)
local STAGE_INFO = {
	index = 4553,
	rows = 0,
	columns = 0
}
local DESK_AVAILABLE_COL = {
	[2] = {
		LEFT = {
			16,
			38
		},
		RIGHT = {
			39,
			61
		}
	},
	[3] = {
		LEFT = {
			23,
			38
		},
		RIGHT = {
			39,
			54
		}
	},
	[4] = {
		LEFT = {
			14,
			38
		},
		RIGHT = {
			39,
			61
		}
	},
	[5] = {
		LEFT = {
			18,
			38
		},
		RIGHT = {
			39,
			54
		}
	},
	[6] = {
		LEFT = {
			17,
			38
		},
		RIGHT = {
			39,
			56
		}
	}
}

function RearHouseDragWall2:ctor(dragCenter, state, zoneName)
	return
end

function RearHouseDragWall2:initRoot(traRoot)
	RearHouseDragWall2.super.initRoot(self, traRoot)

	traRoot.eulerAngles = Vector3(0, 0, 0)

	self:setReflectCamera()
end

function RearHouseDragWall2:initData(...)
	RearHouseDragWall2.super.initData(self)
end

function RearHouseDragWall2:_getCurStageInfo(...)
	return STAGE_INFO
end

function RearHouseDragWall2:getDeskPosConfig(...)
	return DESK_AVAILABLE_COL[self.index]
end

function RearHouseDragWall2:setReflectCamera(...)
	local go = UnityEngine.GameObject.Find("Wall" .. self.index)

	if go then
		local art = go.transform.parent
		local tran = art:Find("Plane")

		if tran then
			local com = tran:GetComponent(typeof(Framework.UI.ReflectivePlaneHelper))

			if com then
				com:ChangeCatchCam(CameraManager.GetMainCamera())

				self.reflectCom = com
			end
		end
	end
end

function RearHouseDragWall2:destroy(...)
	RearHouseDragWall2.super.destroy(self)

	if self.reflectCom then
		self.reflectCom:RevertCatchCam()

		self.reflectCom = nil
	end
end

return RearHouseDragWall2
