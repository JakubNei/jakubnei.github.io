



Story
So at work I was assigned to investigate a Garbage Collector spike on server, which causes rubber badning on client.


After investigating with Superiminal Performance we can see that the hitch is caused by GC::PerformanceReachbilityAnalysis.

Why woud this take so long ? We simply ahve too many UObjects !
After looking around UE documentation suggests Actor Clusering as way to mitigate this
https://docs.unrealengine.com/4.27/en-US/ProgrammingAndScripting/ProgrammingWithCPP/UnrealArchitecture/Objects/Optimizations/

These are the default settings in UE 5.2 from 

"\Engine\Config\BaseEngine.ini"

[/Script/Engine.GarbageCollectionSettings]
gc.MaxObjectsNotConsideredByGC=1
gc.SizeOfPermanentObjectPool=0
gc.FlushStreamingOnGC=0
gc.NumRetriesBeforeForcingGC=10
gc.AllowParallelGC=True
gc.TimeBetweenPurgingPendingKillObjects=61.1
gc.MaxObjectsInEditor=25165824
gc.IncrementalBeginDestroyEnabled=True
gc.CreateGCClusters=True
gc.MinGCClusterSize=5
gc.AssetClustreringEnabled=False
gc.ActorClusteringEnabled=False
gc.BlueprintClusteringEnabled=False
gc.UseDisregardForGCOnDedicatedServers=False
gc.MultithreadedDestructionEnabled=True
gc.VerifyGCObjectNames=True
gc.VerifyUObjectsAreNotFGCObjects=False
gc.PendingKillEnabled=True


For some reason Actor Clustering is disabled by default. My theory is that it is helpful for static scenes, but since Fortnite has fully dynamic enfironment it is not useful there as it would cause objects to be kept in memory until all objects in GC cluster are destroyed.

so lets enable it by adding

to the bottom of
"\Game\Config\DefaultEngine.ini"

[/Script/Engine.GarbageCollectionSettings]
gc.AssetClustreringEnabled=True


Oala, after this, the server no longer shows GC::ReachablityAnalysis spikes.

What is ReachablityAnalysis ?
How does garbage collection work ?
What is ctor clustering ?
Why isn't this enabled by default ?
What is the drawback ?