AddCSLuaFile()
SWEP.PrintName = "Bank Gun"
SWEP.Author = "Aurilau"
SWEP.Purpose = "Summon banks at your aiming pos."
SWEP.Slot = 1
SWEP.SlotPos = 2
SWEP.Spawnable = true
SWEP.ViewModel = Model("models/weapons/c_smg1.mdl")
SWEP.WorldModel = Model("models/weapons/w_smg1.mdl")
SWEP.ViewModelFOV = 54
SWEP.UseHands = true
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.DrawAmmo = false
SWEP.AdminOnly = true
local ShootSound = Sound("NPC_Hunter.FlechetteShoot")

function SWEP:Initialize()
    self:SetHoldType("smg")
end

function SWEP:Reload()
end

function SWEP:PrimaryAttack()
    self:SetNextPrimaryFire(CurTime() + 0.03)
    self:EmitSound(ShootSound)
    if CLIENT then return end

    Justified.Itembank.CreateSequence(self.Owner, self.Owner:GetEyeTrace().HitPos, function(caller, bank)
        if bank and IsValid(bank) then
            bank:Remove()
        end
    end)
end

function SWEP:SecondaryAttack()
end

function SWEP:ShouldDropOnDie()
    return false
end