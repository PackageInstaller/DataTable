local spines ={}
local animStates = {}
local recovers = {}

function Awake()
    spines = ComUtil.GetComsInChildren(gameObject,"CSpine")
end

function InitAnim()
    if spines and spines.Length> 0  then
        for i = 0, spines.Length - 1 do
            if not IsNil(spines[i]) then
                recovers[i] = recovers[i] or 0
                spines[i]:SetComplete0(function ()
                    if recovers[i] == 0 then
                        local anim = spines[i].animationState
                        local te = anim:SetAnimation(0, "idle", true)
                        te.Loop = true
                        te.TrackTime = 0
                        te.TimeScale = 1
                        recovers[i] = 1
                    end
                end)
            end
        end
    end
end

function PlayAnim()
    if spines and spines.Length> 0  then
        for i = 0, spines.Length - 1 do
            if not IsNil(spines[i]) then
                local anim = spines[i].animationState
                local te = anim:SetAnimation(0, "in", false)
                te.Loop = false
                te.TrackTime = 0
                te.TimeScale = 1
                recovers[i] = 0
            end
        end
    end
end