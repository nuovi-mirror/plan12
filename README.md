[ MIRROR OF http://plan12os.org ]

Plan 12 - A Post-UNIX Operating System Architecture
"UNIX? Never heard of it."

Plan 12 is a lineage of research operating systems
designed under the radical model eliminating the
traditional kernel and scheduler entirely and replacing
it with properly decentralized processes communicating

Plan 12 is not a microkernel or exokernel
				
In Plan 12, everything from performing actions  
on hardware devices, scheduling, IPC, and so on are not simply
represented as files, but are files in the literal sense.<br><br>
Vans Plan 12 (vp12) is the reference implementation
of Plan 12, comparable as Class 1 with spec version 2, 
preserving the kernel-less and file centric design.

Vans Plan 12 implements this via global memory structures
with layouts similar to filesystems used to encode system
concepts, such as processes, state, IPC, and so on. However,
unlike in most operating systems, these structures are used
in the literal sense as both the interface and the internal storage
of the concept, making everything truly a file operation all the
way down. De-centralized processes expose IPC files
representing a device or action and self-schedule via a simple
primitive used to bind one filesystem to an execution unit, allowing
for simple de-centralized scheduling without a scheduler. All of
this manages to eliminate the need for a traditional kernel and
scheduler entirely while still allowing for everything to be internally
represented and exposed as a simple file-like interface to both
processes and the system itself (since there is no hard-line distinction
between subsystems).

Plan 12 is a fully public domain specification, alongside a
public domain reference implementation written in assembler
language for the Intel 64 architecture.
Plan 12 (and vp12) have been in development for about
two years now, but are not expected to be in a complete form.
A final release date is not specified, but please note the system
should still be considered early alpha / demo.

Why? Because it does not appear to have been explored. Plan 12 aims
to be a feature-complete, compact, and most of all, highly uniform
and elegant operating system while removing the two most critical 
parts. It aims to simply answer questions about the model. Why has
this not been explored yet? Is it a viable architecture? If so, what
advantages does it bring? At it's core, Plan 12 is a research system
designed to simply ask a few questions and explore an alternative
systems architecture. So far, it appears the model should be viable,
but further research is needed.
				
More projects made by me can be found on my Codeberg profile 
- (https://codeberg.org/vantheman/)
Thanks for reading!
