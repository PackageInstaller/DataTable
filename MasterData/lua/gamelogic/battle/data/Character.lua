if DamageShareData == nil then
    DamageShareData = DataClass("DamageShareData", {
        Id = 0,
        SourceUnit = nil,
        SharedPercent = 0,
        
        __init = function(self, sourceUnit, sharedPercent)
            self.Id = DamageShareData.GenId()
            self.SourceUnit = sourceUnit
            self.SharedPercent = sharedPercent
        end
    })
    
    DamageShareData.IdSeed = 0
    function DamageShareData.GenId()
        DamageShareData.IdSeed = DamageShareData.IdSeed + 1
        return DamageShareData.IdSeed
    end

    function DamageShareData.ResetIdSeed()
        DamageShareData.IdSeed = 0
    end
end