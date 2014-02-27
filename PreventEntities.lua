
-- PreventEntities.lua

-- Implements the entire plugin

--[[
  This plugin aims to lower the load on creative build servers, by preventing certain entities to spawn.
The prevented entities can be configured via a config file, PreventEntities.ini, in the MCS exe folder.
--]]





local g_PreventSpawn = {}





local function OnSpawningEntity(a_World, a_Entity)
	assert(a_Entity ~= nil)
	
	-- If the entity type is to be prevented, disable the spawn:
	if (g_PreventSpawn[a_Entity:GetEntityType()]) then
		return true
	end
	
	-- Allow the entity to spawn:
	return false
end





function Initialize(a_Plugin)
	-- Read the configuration:
	local Cfg = cIniFile()
	Cfg:ReadFile("PreventEntities.ini")
	g_PreventSpawn[cEntity.etBoat]         = Cfg:GetValueSetB("PreventEntityTypes", "Boat",         false)
	g_PreventSpawn[cEntity.etExpOrb]       = Cfg:GetValueSetB("PreventEntityTypes", "ExpOrb",       false)
	g_PreventSpawn[cEntity.etFallingBlock] = Cfg:GetValueSetB("PreventEntityTypes", "FallingBlock", false)
	g_PreventSpawn[cEntity.etFloater]      = Cfg:GetValueSetB("PreventEntityTypes", "Floater",      false)
	g_PreventSpawn[cEntity.etItemFrame]    = Cfg:GetValueSetB("PreventEntityTypes", "ItemFrame",    false)
	g_PreventSpawn[cEntity.etMinecart]     = Cfg:GetValueSetB("PreventEntityTypes", "Minecart",     false)
	g_PreventSpawn[cEntity.etMob]          = Cfg:GetValueSetB("PreventEntityTypes", "Mob",          false)
	g_PreventSpawn[cEntity.etPainting]     = Cfg:GetValueSetB("PreventEntityTypes", "Painting",     false)
	g_PreventSpawn[cEntity.etPickup]       = Cfg:GetValueSetB("PreventEntityTypes", "Pickup",       false)
	g_PreventSpawn[cEntity.etProjectile]   = Cfg:GetValueSetB("PreventEntityTypes", "Projectile",   false)
	g_PreventSpawn[cEntity.etTNT]          = Cfg:GetValueSetB("PreventEntityTypes", "TNT",          false)
	Cfg:WriteFile("PreventEntities.ini")
	
	-- Add the spawn-hook:
	cPluginManager:AddHook(cPluginManager.HOOK_SPAWNING_ENTITY, OnSpawningEntity)
	
	return true;
end




