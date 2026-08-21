local UIVotingHeroSceneCtrl = BaseClass("UIVotingHeroSceneCtrl", UIBaseComponent)
local M = UIVotingHeroSceneCtrl

function M:SetHero(heroId)
    if heroId == 0 then
        if self._heroId > 0 then
            RoleBehaviorCtrl:GetInstance():RemoveGirl(self._heroId)
        end
        return 
    end
    
    -- RoleBehaviorCtrl:GetInstance():RemoveGirl(self._heroId)
    self._heroId = heroId
    RoleBehaviorCtrl:GetInstance():RemoveAllGirls()
    self._girlBeavourCtrl = RoleBehaviorCtrl:GetInstance():CreateCommonGirl(heroId, true, 7, 1,RoleUse.Vote)
    self._girlBeavourCtrl:Run()
    local shorGirl = self._girlBeavourCtrl:GetGirl()
    shorGirl.transform:SetParent(self._view.girlPos)
    shorGirl.transform:Reset()
end

function M:SetPos(x, y, z)
    self._view.transform:SetPos(x, y, z)
end

function M:SetCam(cam)
    local camPosTrans = self._view.camPos
    local trans = cam.transform
    trans:SetPositionAndRotation(camPosTrans)
    local type = typeof(CS.SpriteAdapter)
    local spriteAdapter = UIUtil.TryGetComponents(trans, type)
    spriteAdapter:AddSprite(self._view.bg, CS.SpriteAdapter.EFillModel.Auto, 17)
end

function M:OnDestroy()
    -- local cam = ICameraMgr:GetMainCamera()
    -- local trans = cam.transform
    -- UIUtil.RemoveComponentByType(trans, typeof(CS.SpriteAdapter))
    -- RoleBehaviorCtrl:GetInstance():RemoveGirl(self._heroId)
    -- self._girlBeavourCtrl = nil
    -- GameUtil.DestroyGo(self._view.gameObject)
    M.super.OnDestroy(self)
end

return UIVotingHeroSceneCtrl
