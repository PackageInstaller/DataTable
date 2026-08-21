-- local VirtualCameraMgr = BaseClass("VirtualCameraMgr", Singleton)
-- local M = VirtualCameraMgr

-- function M:ChangeCameraDirector(moduleId, cameracontent)
--     self._csVirualCameraMgr = CS.GameX.Battle.VirtualCameraManager.Instance
--     if self._csVirualCameraMgr == nil then
--         -- body
--         return
--     end
--     local exsitDirector = false
--     for k, v in pairs(ModuleConfig) do
--         if v.id == moduleId and v.director then
--             exsitDirector = true
--         end
--     end
--     if not exsitDirector then
--         self._csVirualCameraMgr:EnableMainCamera(false)
--         return
--     end
--     if type(moduleId) == "string" then
--         self._csVirualCameraMgr:ChangeCameraDirector(moduleId)
--     elseif type(moduleId) == "number" then
--         self._csVirualCameraMgr:LuaChangeCameraDirector(moduleId, cameracontent)
--     end
-- end

-- function M:ChangeMainCameraPos(x, y, z, rx, ry, rz)
--     if self.instance then
--         self.instance:SetCameraTransform(x, y, z, rx, ry, rz)
--     end
-- end

-- function M:SwitchVirtualCamera(camName, fov)
--     self.instance:SwitchVirtualCamera(camName, fov)
-- end

-- function M:CameraTranslation(duration, x, y, z, rx, ry, rz)
--     self.instance:CameraTranslation(duration, x, y, z, rx, ry, rz)
-- end

-- function M:SetTargetAndLookAt(heroTransform)
--     self.instance:SetTargetAndLookAt(heroTransform)
-- end

-- -- function M:DisposeCameraDirector()
-- --     self._csVirualCameraMgr:LusDisposeCameraDirector()
-- -- end

-- function M:Set(...)
--     -- body
-- end

-- function M:Cleanup()
-- end

-- function M:Dispose()
--     if self.instance and self.instance.Dispose then
--         self.instance:Dispose()
--     end
--     self.instance = nil
-- end

-- -------------------------------------------------------------------------
-- function M:__CreateDirector(moduleId, csLuaCameraDirector, cameraContent)
--     if self.instance and self.instance.Dispose then
--         self.instance:Dispose()
--     end
--     self.instance = nil
--     for k, v in pairs(ModuleConfig) do
--         if v.id == moduleId and v.director then
--             local cls = require(v.director)
--             self.instance = cls.New(csLuaCameraDirector, cameraContent)
--         end
--     end
-- end

-- function M:GetCsVirualCameraMgr()
--     return self._csVirualCameraMgr
-- end

-- ------------------------------------------------------------------------

-- return VirtualCameraMgr
